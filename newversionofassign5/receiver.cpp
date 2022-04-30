/*
 * Chat server
 * CSF Assignment 5
 * Chujian Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 * 
 */

#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include "csapp.h"
#include "message.h"
#include "connection.h"
#include "client_util.h"


/*
 * The main function. 
 *
 * Parameters:
 *   argc - number of arguments
 *   argv - the argument vector
 *
 * Returns:
 *   0 if executed successfully, nonzero if in error
 */

int main(int argc, char **argv) {
  if (argc != 5) {
    std::cerr << "Usage: ./receiver [server_address] [port] [username] [room]\n";
    return 1;
  }

  std::string server_hostname = argv[1];
  int server_port = std::stoi(argv[2]);
  std::string username = argv[3];
  std::string room_name = argv[4];

  Connection conn;

  // TODO: connect to server
  conn.connect(server_hostname, server_port);
  if (!conn.is_open()) {
    std::cerr<< "connection failure" <<std::endl;
    return -1;
  }

  // TODO: send rlogin and join messages (expect a response from
  //       the server for each one)
  Message rlogin = {TAG_RLOGIN, username};
  Message ok_response;
  conn.send(rlogin);
  if (!conn.receive(ok_response)) {
    std::cerr << ok_response.data;
    return -1;
  }

  //TODO: send join
  Message join = {TAG_JOIN, room_name};
  conn.send(join);
  if (!conn.receive(ok_response)) {
    std::cerr << ok_response.data;
    return -1;
  }


  // TODO: loop waiting for messages from server
  //       (which should be tagged with TAG_DELIVERY)
  Message from_server;
  while (true) {
    do {
      if (!conn.receive(from_server)){
        std::cerr << from_server.data;
      }
    } while (from_server.tag != TAG_DELIVERY);

   std::vector<std::string> message = from_server.split_payload();
   std::cout << message[1] <<": " << message[2];
  }
  return 0;
}
