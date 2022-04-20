#include <sstream>
#include <cctype>
#include <cassert>
#include "csapp.h"
#include "message.h"
#include "connection.h"

//TODO: testing
#include <iostream>


Connection::Connection()
  : m_fd(-1)
  , m_last_result(SUCCESS) {
}

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
  // std::cout<<"[send]to send:" <<tag_payload << std::endl;
  int n = rio_writen(m_fd, tag_payload.c_str(), tag_payload.length());
  // std::cout<<"[send]sent:" <<tag_payload << std::endl;
  // rio_writen(m_fd, "\n", 1);
  // Message response;
  // receive(response);
  if (n <= 0) {
    m_last_result = Connection::Result::EOF_OR_ERROR;
    return false;
  }
  m_last_result = Connection::Result::SUCCESS;
  return true;
  
  // if (response.tag == TAG_OK) {
  //   m_last_result = Connection::Result::SUCCESS;
  //   return true;
  // }
  // if (response.tag == TAG_ERR) {
  //   m_last_result = Connection::Result::EOF_OR_ERROR;
  //   return false;
  // }
  // char buf_2[1000];
  // int n = rio_readlineb(&m_fdbuf, buf_2, sizeof(buf_2)-1);
  // buf_2[n] = '\0';
  // std::string result(buf_2);
  // std::cout << "[send]conn received: "<< result;
  // if (n > 0 && result.substr(0,3).compare("ok:") == 0) {
  //   m_last_result = Connection::Result::SUCCESS;
  //   std::cout << "[send]result: success; exiting" << std::endl;
  //   return true;
  // } else {
  //   m_last_result = Connection::Result::EOF_OR_ERROR;
  // }
  // return false;
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
