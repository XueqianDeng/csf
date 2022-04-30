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

struct ConnInfo {
  Connection *conn;
  Server *server;

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

void *worker(void *arg) {
  pthread_detach(pthread_self());
  // std::cout<<"[worker] init"<<std::endl;

  ConnInfo *info_ = static_cast<ConnInfo *>(arg);

  // use a std::unique_ptr to automatically destroy the ConnInfo object
  // when the worker function finishes; this will automatically ensure
  // that the Connection object is destroyed
  std::unique_ptr<ConnInfo> info(info_);

  Message msg;

  if (!info->conn->receive(msg)) {
    if (info->conn->get_last_result() == Connection::INVALID_MSG) {
      info->conn->send(Message(TAG_ERR, "invalid message"));
    }
    return nullptr;
  }
  // std::cout<<"[worker] msg tag: " <<msg.tag<<std::endl;

  if (msg.tag != TAG_SLOGIN && msg.tag != TAG_RLOGIN) {
    info->conn->send(Message(TAG_ERR, "first message should be slogin or rlogin"));
    return nullptr;
  }


  std::string username = msg.data;
  if (!info->conn->send(Message(TAG_OK, "welcome " + username))) {
    // std::cout<<"[worker] failed to send login msg: "<<std::endl;
    return nullptr;
  } 
  //TODO: to delete else stmt
  else {
    // std::cout<<"[worker] succeeded to send login msg: "<<std::endl;
  }
  User * user = nullptr;
  if (msg.tag == TAG_RLOGIN) { //only registers user when it's receiver
    user = new User(username);
  }
  

  // Just loop reading messages and sending an ok response for each one
  while (true) {
    // std::cout<<"waiting"<<std::endl;
    if (!info->conn->receive(msg)) {
      // std::cout<<"[worker] not received "<<std::endl;
      if (info->conn->get_last_result() == Connection::INVALID_MSG) {
        // std::cout<<"[worker] invalid msg received "<<std::endl;
        info->conn->send(Message(TAG_ERR, "invalid message"));
        
      }
      break;
      
    }

    // if (!info->conn->send(Message(TAG_OK, "this is just a dummy response"))) {
    //   std::cout<<"[worker] failed to send ok "<<std::endl;
    //   break;
    // }
    // std::cout<<user<<"[worker] server got msg: " << msg.tag <<": " <<msg.data <<std::endl;
    Room* rm;
    if (msg.tag == TAG_JOIN) {
      // std::cout<<"[worker] trying to add to room "<<std::endl;
      // pthread_mutex_lock(&info->server->m_lock);//TODO: before this, failed new connections but didn't fail room change
      rm = info->server->find_or_create_room(msg.data);
      // pthread_mutex_unlock(&info->server->m_lock);
      // std::cout<<"[worker] added to room "<<std::endl;
      if (user != nullptr) { //if receiver
        rm->add_member(user);
      }
      info->conn->send(Message(TAG_OK, "added to room"));
      // rm->print_member();
    }

    if (msg.tag == TAG_SENDALL) {
      // std::cout<<user<<"[worker] sending... "<<msg.data<<std::endl;
      rm->broadcast_message(username, msg.data);
      info->conn->send(Message(TAG_OK, "sent all to room"));
      
    }

    if (msg.tag == TAG_QUIT) {
      // std::cout<<user<<"[worker] sending... "<<msg.data<<std::endl;
      info->conn->send(Message(TAG_OK, "quitting"));
      return nullptr;
      
    }

    if (user != nullptr) {
        // std::cout<<"[worker] fetching deliv... "<<std::endl;
      Message * deque_msg;
      while (true) {
        
        deque_msg = user->mqueue.dequeue();
        
        if (deque_msg != nullptr) {
          // std::cout<<"receiver[worker] got: "<<deque_msg->data<<std::endl;
          // std::cout<<"[worker] receiving delivery"<<std::endl;
          info->conn->send(Message(TAG_DELIVERY, deque_msg->data));
          delete deque_msg;
        }
        
      }

    }
    
  }

  return nullptr;
}

}

////////////////////////////////////////////////////////////////////////
// Server member function implementation
////////////////////////////////////////////////////////////////////////

Server::Server(int port)
  : m_port(port)
  , m_ssock(-1) {
  pthread_mutex_init(&m_lock, nullptr);
}

Server::~Server() {
  pthread_mutex_destroy(&m_lock);
}

bool Server::listen() {
  std::string port = std::to_string(m_port);
  m_ssock = open_listenfd(port.c_str());

  // std::cout<<"[listen]"<<std::endl;

  return m_ssock >= 0;
}

void Server::handle_client_requests() {
  assert(m_ssock >= 0);

  while (true) {
    int clientfd = accept(m_ssock, nullptr, nullptr);
    if (clientfd < 0) {
      std::cerr << "Error accepting connection\n";
      return;
    }

    // std::cout<<"[handle] accepted"<<std::endl;

    ConnInfo *info = new ConnInfo(new Connection(clientfd), this);

    pthread_t thr_id;
    if (pthread_create(&thr_id, nullptr, worker, static_cast<void *>(info)) != 0) {
      std::cerr << "Could not create thread\n";
      return;
    }
  }
}

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
