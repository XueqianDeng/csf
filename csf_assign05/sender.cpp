#include <iostream>
#include <string>
#include <sstream>
#include <stdexcept>
#include "csapp.h"
#include "message.h"
#include "connection.h"
#include "client_util.h"

/*
 * This is the function to send comment and return 
 * false if entered /quit, true otherwise
 *
 * Parameters:
 *   conn - the connection object
 *   input - the input of the user 
 * 
 * Returns:
 *   return true if successful otherwise false
 */
bool send_command(Connection& conn, std::string input) {
  if (input.compare("/quit") == 0) {
      Message quit = {TAG_QUIT, ""};
      conn.send(quit);
      return false;
    }
    else if (input.compare("/leave") == 0) {
      Message leave = {TAG_LEAVE, ""};
      conn.send(leave);
    }
    else if (input.length() >= 5 && input.substr(0,5).compare("/join") == 0) {
      std::string rm_name = input.substr(6, input.length());
      Message join = {TAG_JOIN, rm_name};
      conn.send(join);
    }
    else {
      Message sendAll = {TAG_SENDALL, input};
      conn.send(sendAll);
    }
    return true;
}

int main(int argc, char **argv) {
  if (argc != 4) {
    std::cerr << "Usage: ./sender [server_address] [port] [username]\n";
    return 1;
  }

  std::string server_hostname = argv[1];
  int server_port = std::stoi(argv[2]);
  std::string username = argv[3];

  Connection conn;

  // TODO: connect to server
  conn.connect(server_hostname, server_port);
  if (!conn.is_open()) {
    std::cerr<< "connection failure" <<std::endl;
    return -1;
  }

  // TODO: send slogin message
  Message slogin = {TAG_SLOGIN, username};
  Message ok_response;
  conn.send(slogin);
  conn.receive(ok_response);
  if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    return -1;
  }
  // TODO: loop reading commands from user, sending messages to
  //       server as appropriate
  std::string input;
  bool proceed = true;
  while (proceed) {
    std::getline(std::cin, input);
    // std::cout << input <<std::endl;
    proceed = send_command(conn, input);
    conn.receive(ok_response);
    if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    }
  }
  return 0;
}
