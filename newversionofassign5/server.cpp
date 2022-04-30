#include <pthread.h>
#include <iostream>
#include <sstream>
#include <memory>
#include <set>
#include <vector>
#include <cctype>
#include <cassert>
#include "message.h"
#include "connection.h"
#include "user.h"
#include "room.h"
#include "guard.h"
#include "server.h"

////////////////////////////////////////////////////////////////////////
// Server implementation data types
////////////////////////////////////////////////////////////////////////

/*
 *  Connection Information Data Structure
 */
struct ConnInfo {
  // introduce basic data structure in the struct
  Connection *conn;
  Server *server;
  
  //constructor and destructor
  ConnInfo(Connection *conn, Server *server) : conn(conn), server(server) { }
  ~ConnInfo() {
    // destroy connection when ConnInfo object is destroyed
    delete conn;
  }
};

////////////////////////////////////////////////////////////////////////
// Client thread functions
////////////////////////////////////////////////////////////////////////

namespace {

 /*
  * This is parsing, or namely, handling function 
  *
  * Parameters:
  *   arg - tells the parsing or say handling function basic info. about the 
  *   what to parse and what to do. 
  */
void *worker(void *arg) {
  pthread_detach(pthread_self());
  
  //intake the info
  ConnInfo *info_ = static_cast<ConnInfo *>(arg);

  // use a std::unique_ptr to automatically destroy the ConnInfo object
  // when the worker function finishes; this will automatically ensure
  // that the Connection object is destroyed
  std::unique_ptr<ConnInfo> info(info_);
  Message msg;
  
  // invalid messsage handling
  if (!info->conn->receive(msg)) {
    if (info->conn->get_last_result() == Connection::INVALID_MSG) {
      info->conn->send(Message(TAG_ERR, "invalid message"));
    }
    return nullptr;
  }

  //check the tag of the message
  if (msg.tag != TAG_SLOGIN && msg.tag != TAG_RLOGIN) {
    info->conn->send(Message(TAG_ERR, "first message should be slogin or rlogin"));
    return nullptr;
  }

  
  std::string username = msg.data;
  if (!info->conn->send(Message(TAG_OK, "welcome " + username))) {
    return nullptr;
  } 
  // to delete else stmt
  User * user = nullptr;
  if (msg.tag == TAG_RLOGIN) { 
    //only registers user when it's receiver
    user = new User(username);
  }

  // Just loop reading messages and sending an ok response for each one
  while (true) {
    if (!info->conn->receive(msg)) {
      if (info->conn->get_last_result() == Connection::INVALID_MSG) {
        info->conn->send(Message(TAG_ERR, "invalid message"));
      }
      break;      
    }
    
    Room* rm;
    if (msg.tag == TAG_JOIN) {
      //before this, failed new connections but didn't fail room change
      rm = info->server->find_or_create_room(msg.data);
      if (user != nullptr) { //if receiver
        rm->add_member(user);
      }
      info->conn->send(Message(TAG_OK, "added to room"));
    }

    if (msg.tag == TAG_SENDALL) {
      rm->broadcast_message(username, msg.data);
      info->conn->send(Message(TAG_OK, "sent all to room"));
    }

    if (msg.tag == TAG_QUIT) {
      info->conn->send(Message(TAG_OK, "quitting"));
      return nullptr;
    }

    if (user != nullptr) {
      Message * deque_msg;
      while (true) {
        deque_msg = user->mqueue.dequeue();     
        if (deque_msg != nullptr) {
          info->conn->send(Message(TAG_DELIVERY, deque_msg->data));
          delete deque_msg;
        }
      }
    }
  }
  return nullptr;
}

// namespace
}
// namespace

////////////////////////////////////////////////////////////////////////
// Server member function implementation
////////////////////////////////////////////////////////////////////////

 /*
  * Create the server object.
  *
  * Parameters:
  *   port - port number
  */
Server::Server(int port)
  : m_port(port)
  , m_ssock(-1) {
  pthread_mutex_init(&m_lock, nullptr);
}

 /*
  * Destroy the server object. 
  *
  */
Server::~Server() {
  pthread_mutex_destroy(&m_lock);
}

 /*
  * See if there is something sent to the server
  */
bool Server::listen() {
  std::string port = std::to_string(m_port);
  m_ssock = open_listenfd(port.c_str());
  return m_ssock >= 0;
}

 /*
  * This is used to handle the client's request. 
  */
void Server::handle_client_requests() {
  assert(m_ssock >= 0);
  while (true) {
    int clientfd = accept(m_ssock, nullptr, nullptr);
    if (clientfd < 0) {
      std::cerr << "Error accepting connection\n";
      return;
    }
    ConnInfo *info = new ConnInfo(new Connection(clientfd), this);
    pthread_t thr_id;
    if (pthread_create(&thr_id, nullptr, worker, static_cast<void *>(info)) != 0) {
      std::cerr << "Could not create thread\n";
      return;
    }
  }
}

 /*
  * This is used to find or to create a room
  *
  * Parameters:
  *   room_name - the string of the room name
  */
Room *Server::find_or_create_room(const std::string &room_name) {
  // this function can be called from multiple threads, so
  // make sure the mutex is held while accessing the shared
  // data (the map of room names to room objects)
  Guard g(m_lock);
  Room *room;
  auto i = m_rooms.find(room_name);
  if (i == m_rooms.end()) {
    // room does not exist yet, so create it and add it to the map
    room = new Room(room_name);
    m_rooms[room_name] = room;
  } else {
    room = i->second;
  }
  return room;
}
