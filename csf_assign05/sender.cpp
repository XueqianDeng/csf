#include <iostream>
#include <string>
#include <sstream>
#include <stdexcept>
#include "csapp.h"
#include "message.h"
#include "connection.h"
#include "client_util.h"


// void join_rm(int fd, char* rm_num, rio_t rio) {
//   //TODO: send join
//     std::string join = "join:";
//     join += rm_num;
//     rio_writen(fd, join.c_str(), join.length());
//     // rio_writen(fd, "\n", 1);
//     rio_readinitb(&rio, fd);
//     char buf_2[1000];
//     int n = rio_readlineb(&rio, buf_2, sizeof(buf_2)-1);
//     if (n > 0) { // print response
//       buf_2[n] = '\0'; // add NUL terminator to received message
//       printf("Received from server: %s", buf_2);
//     }
//   }



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

  Connection conn;

  // TODO: connect to server
  conn.connect(server_hostname, server_port);
  if (!conn.is_open()) {
    std::cerr<< "connection failure" <<std::endl;
    return -1;
  }
  // std::cout << "connected" << std::endl;

  // TODO: send slogin message
  Message slogin = {TAG_SLOGIN, username};
  Message ok_response;
  conn.send(slogin);
  conn.receive(ok_response);
  if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    return -1;
  }
  // std::cout << "login success" << std::endl;
  // TODO: loop reading commands from user, sending messages to
  //       server as appropriate
  std::string input;
  bool loop = true;
  while (loop) {
    std::getline(std::cin, input);
    // std::cout << input <<std::endl;
    if (input.compare("/quit") == 0) {
      loop = false;
      Message quit = {TAG_QUIT, ""};
      conn.send(quit);
    }
    else if (input.compare("/leave") == 0) {
      Message leave = {TAG_LEAVE, ""};
      conn.send(leave);
    }
    else if (input.length() >= 5 && input.substr(0,5).compare("/join") == 0) {
      std::string rm_name = input.substr(6, input.length());
      // std::cin >> rm_name;
      Message join = {TAG_JOIN, rm_name};
      conn.send(join);
      // std::cout << "joined successfully to: "<< rm_name << std::endl;
    }
    else {
      Message sendAll = {TAG_SENDALL, input};
      conn.send(sendAll);
      // std::cout << "already sent: " << input << std::endl;
    }
    conn.receive(ok_response);
    if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    }
  }

  // // // TODO: connect to server
  // // int fd = open_clientfd(argv[1], argv[2]);
  // // if (fd < 0) {
  // //   // fatal("Couldn't connect to server"); 
  // // }

  // // TODO: send rlogin and join messages (expect a response from
  // //       the server for each one)
  // //TODO: send rlogin
  // std::string usr = "slogin:";
  // usr += argv[3];
  // rio_writen(fd, usr.c_str(), usr.length());
  // // rio_writen(fd, "\n", 1);
  // rio_t rio; // read response from server
  // rio_readinitb(&rio, fd);
  // char buf[1000];
  // ssize_t n = rio_readlineb(&rio, buf, sizeof(buf)-1);
  // if (n > 0) { // print response
  // buf[n] = '\0'; // add NUL terminator to received message
  // printf("Received from server: %s", buf);
  // }
  // bool loop = true;
  // std::string input;
  // while (loop) {
  //   std::cin >> input;
  //   if (input.compare("/quit") == 0) {
  //     loop = false;
  //   }
  //   else if (input.compare("/leave")) {
      
  //   }
  //   else if (input.compare("/join")) {
  //     char* rm_num;
  //     std::cin >> rm_num;
  //     join_rm(fd,rm_num,rio);
  //   }
  // }

  

  
  
  

  return 0;
}
