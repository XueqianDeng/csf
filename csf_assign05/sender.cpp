#include <iostream>
#include <string>
#include <sstream>
#include <stdexcept>
#include "csapp.h"
#include "message.h"
#include "connection.h"
#include "client_util.h"


void join_rm(int fd, char* rm_num, rio_t rio) {
  //TODO: send join
    std::string join = "join:";
    join += rm_num;
    rio_writen(fd, join.c_str(), join.length());
    // rio_writen(fd, "\n", 1);
    rio_readinitb(&rio, fd);
    char buf_2[1000];
    int n = rio_readlineb(&rio, buf_2, sizeof(buf_2)-1);
    if (n > 0) { // print response
      buf_2[n] = '\0'; // add NUL terminator to received message
      printf("Received from server: %s", buf_2);
    }
  }



int main(int argc, char **argv) {
  if (argc != 4) {
    std::cerr << "Usage: ./sender [server_address] [port] [username]\n";
    return 1;
  }

  std::string server_hostname;
  int server_port;
  std::string username;

  server_hostname = argv[1];
  server_port = std::stoi(argv[2]);
  username = argv[3];

  // TODO: connect to server

  // TODO: send slogin message

  // TODO: loop reading commands from user, sending messages to
  //       server as appropriate


  // TODO: connect to server
  int fd = open_clientfd(argv[1], argv[2]);
  if (fd < 0) {
    // fatal("Couldn't connect to server"); 
  }

  // TODO: send rlogin and join messages (expect a response from
  //       the server for each one)
  //TODO: send rlogin
  std::string usr = "slogin:";
  usr += argv[3];
  rio_writen(fd, usr.c_str(), usr.length());
  // rio_writen(fd, "\n", 1);
  rio_t rio; // read response from server
  rio_readinitb(&rio, fd);
  char buf[1000];
  ssize_t n = rio_readlineb(&rio, buf, sizeof(buf)-1);
  if (n > 0) { // print response
  buf[n] = '\0'; // add NUL terminator to received message
  printf("Received from server: %s", buf);
  }
  bool loop = true;
  std::string input;
  while (loop) {
    std::cin >> input;
    if (input.compare("/quit") == 0) {
      loop = false;
    }
    else if (input.compare("/leave")) {
      
    }
    else if (input.compare("/join")) {
      char* rm_num;
      std::cin >> rm_num;
      join_rm(fd,rm_num,rio);
    }
  }

  

  
  
  

  return 0;
}
