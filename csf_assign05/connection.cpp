#include <sstream>
#include <cctype>
#include <cassert>
#include "csapp.h"
#include "message.h"
#include "connection.h"

//TODO: testing
#include <iostream>

/*
 * To construct a connection object instance with '-1'.
 *
 */
Connection::Connection()
  : m_fd(-1)
  , m_last_result(SUCCESS) {
}

/*
 * To get the endianness of a valid elf file
 *
 * Parameters:
 *   fd - the pointer to elf header
 *
 * Returns:
 *   a string containning the corresponding endianness of the valid elf file
 */
Connection::Connection(int fd)
  : m_fd(fd)
  , m_last_result(SUCCESS) {
  // TODO: call rio_readinitb to initialize the rio_t object
  rio_readinitb(&m_fdbuf, m_fd);
}

void Connection::connect(const std::string &hostname, int port) {
  // TODO: call open_clientfd to connect to the server
  m_fd = open_clientfd(hostname.c_str(), std::to_string(port).c_str());
  // TODO: call rio_readinitb to initialize the rio_t object
  rio_readinitb(&m_fdbuf, m_fd);
}

Connection::~Connection() {
  // TODO: close the socket if it is open
  
}

bool Connection::is_open() const {
  // TODO: return true if the connection is open
  return m_fd >= 0;
}

void Connection::close() {
  // TODO: close the connection if it is open
  if (m_fd >= 0) {
    Close(m_fd);
    m_fd = -1;
  }
}

bool Connection::send(const Message &msg) {
  // TODO: send a message
  // return true if successful, false if not
  // make sure that m_last_result is set appropriately
  std::string tag_payload = msg.tag+":"+msg.data;
  tag_payload += '\n';
  int n = rio_writen(m_fd, tag_payload.c_str(), tag_payload.length());
  if (n <= 0) {
    m_last_result = Connection::Result::EOF_OR_ERROR;
    return false;
  }
  m_last_result = Connection::Result::SUCCESS;
  return true;
}

bool Connection::receive(Message &msg) {
  // TODO: send a message, storing its tag and data in msg
  // return true if successful, false if not
  // make sure that m_last_result is set appropriately
    char buf_3[1000];
    int n = rio_readlineb(&m_fdbuf, buf_3, sizeof(buf_3)-1);
    if (n > 0) { // print response
      buf_3[n] = '\0'; // add NUL terminator to received message
      std::string message(buf_3);
      int colon_idx = message.find(":");
      msg.data = message.substr(colon_idx + 1, message.length() - 1);
      // std::vector<std::string> vec = msg.split_payload();
      msg.tag = message.substr(0, colon_idx);
      // std::cout<<msg.tag;
      m_last_result = Connection::Result::SUCCESS;
      return true;
    } else {
      msg.tag = TAG_EMPTY;
      m_last_result = Connection::Result::EOF_OR_ERROR;
    }
    return false;
}
