#include <sstream>
#include <cctype>
#include <cassert>
#include "csapp.h"
#include "message.h"
#include "connection.h"

#include <iostream>

/*
 * To construct a connection object instance with file descriptor '-1'.
 */
Connection::Connection()
  : m_fd(-1)
  , m_last_result(SUCCESS) {
}

/*
 * To construct a connection object with a given file descriptor. 
 *
 * Parameters:
 *   fd - file descriptor
 */
Connection::Connection(int fd)
  : m_fd(fd)
  , m_last_result(SUCCESS) {
  rio_readinitb(&m_fdbuf, m_fd);
}

/*
 * To connect the client
 *
 * Parameters:
 *   hostname - the name of the host
 *   port - port number
 */
void Connection::connect(const std::string &hostname, int port) {
  // call open_clientfd to connect to the server
  m_fd = open_clientfd(hostname.c_str(), std::to_string(port).c_str());
  // call rio_readinitb to initialize the rio_t object
  rio_readinitb(&m_fdbuf, m_fd);
}

/*
 * destructor function for the connection object.
 */
Connection::~Connection() {
  // TODO: close the socket if it is open
  if (m_fd >= 0) {
    close();
  }
}

/*
 * To check if the connection is open. 
 *
 * Returns:
 *  the boolean value of whether the connection is open or not. 
 */
bool Connection::is_open() const {
  // TODO: return true if the connection is open
  return m_fd >= 0;
}

/*
 * This function is used to close the connection
 */
void Connection::close() {
  if (m_fd >= 0) {
    Close(m_fd);
    m_fd = -1;
  }
}

/*
 * This function is used to send the message through the connection object. 
 *
 * Parameters:
 *   msg - the message that the user wants to send. 
 *
 * Returns:
 *   whether the message is sent successfully. 
 */
bool Connection::send(const Message &msg) {
  // TODO: send a message
  std::string tag_payload = msg.tag+":"+msg.data;
  if (tag_payload.back() != '\n') {
    tag_payload += '\n';
  }
  size_t n = rio_writen(m_fd, tag_payload.c_str(), tag_payload.length());
  if (n < tag_payload.length()) {
    m_last_result = Connection::Result::EOF_OR_ERROR;
    return false;
  }
  m_last_result = Connection::Result::SUCCESS;
  return true;
}

/*
 * This function is used to recieve the message through the connection object. 
 *
 * Parameters:
 *   msg - the message to be written 
 *
 * Returns:
 *   whether the message is sent successfully. 
 */
bool Connection::receive(Message &msg) {
    char buf_3[1000];
    int n = rio_readlineb(&m_fdbuf, buf_3, sizeof(buf_3)-1);
    if (n > 0) { // print response
      buf_3[n] = '\0'; // add NUL terminator to received message
      std::string message(buf_3);
      int colon_idx = message.find(":");
      msg.data = message.substr(colon_idx + 1, message.length() - 1);
      msg.tag = message.substr(0, colon_idx);
      if (msg.tag != TAG_ERR && msg.tag != TAG_OK && msg.tag != TAG_SLOGIN && msg.tag != TAG_DELIVERY &&
        msg.tag != TAG_JOIN && msg.tag != TAG_LEAVE && msg.tag != TAG_SENDALL && msg.tag != TAG_SENDUSER &&
        msg.tag != TAG_DELIVERY && msg.tag != TAG_EMPTY && msg.tag != TAG_RLOGIN && msg.tag != TAG_QUIT) {
        m_last_result = Connection::Result::INVALID_MSG;
        return false;
      }
      if (msg.tag == TAG_ERR) {
        m_last_result = Connection::Result::EOF_OR_ERROR;
        return false;
      }
      m_last_result = Connection::Result::SUCCESS;
      return true;
    } else {
      msg.tag = TAG_EMPTY;
      m_last_result = Connection::Result::EOF_OR_ERROR;
    }
    return false;
}
