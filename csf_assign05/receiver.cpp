#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include "csapp.h"
#include "message.h"
#include "connection.h"
#include "client_util.h"

// bool concat(char* tag, ){
//   char filename[128];
//   char* name = "hello";
//   char* extension = ".txt";

//   if (sizeof(filename) < strlen(name) + 1 ) { /* +1 is for null character */
//       fprintf(stderr, "Name '%s' is too long\n", name);
//       return EXIT_FAILURE;
//   }
//   strncpy(filename, name, sizeof(filename));

//   if (sizeof(filename) < (strlen(filename) + strlen(extension) + 1) ) {
//       fprintf(stderr, "Final size of filename is too long!\n");
//       return EXIT_FAILURE;
//   }
//   strncat(filename, extension, (sizeof(filename) - strlen(filename)) );
//   printf("Filename is %s\n", filename);
// }
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
  // std::cout << "before connect" << std::endl;

  // TODO: connect to server
  // int fd = open_clientfd(argv[1], argv[2]);
  // if (fd < 0) {
  //   // fatal("Couldn't connect to server"); 
  // }
  conn.connect(server_hostname, server_port);
  if (!conn.is_open()) {
    std::cerr<< "connection failure" <<std::endl;
    return -1;
  }
  // std::cout << "connected" << std::endl;

  // TODO: send rlogin and join messages (expect a response from
  //       the server for each one)
  //TODO: send rlogin
  // std::string usr = "rlogin:";
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
  Message rlogin = {TAG_RLOGIN, username};
  Message ok_response;
  conn.send(rlogin);
  conn.receive(ok_response);
  if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    return -1;
  }
  // std::cout << "[main]login success" << std::endl;

  //TODO: send join
  // std::string join = "join:";
  // join += argv[4];
  // rio_writen(fd, join.c_str(), join.length());
  // // rio_writen(fd, "\n", 1);
  // rio_readinitb(&rio, fd);
  // char buf_2[1000];
  // n = rio_readlineb(&rio, buf_2, sizeof(buf_2)-1);
  // if (n > 0) { // print response
  // buf_2[n] = '\0'; // add NUL terminator to received message
  // printf("Received from server: %s", buf_2);
  // }
  Message join = {TAG_JOIN, room_name};
  conn.send(join);
  conn.receive(ok_response);
  if (ok_response.tag == TAG_ERR) {
    std::cerr << ok_response.data;
    return -1;
  }
  // std::cout << "[main]joined successfully" << std::endl;

  // TODO: loop waiting for messages from server
  //       (which should be tagged with TAG_DELIVERY)
  Message from_server;
  while (true) {
    // rio_readinitb(&rio, fd);
    // char buf_3[1000];
    // n = rio_readlineb(&rio, buf_3, sizeof(buf_3)-1);
    // if (n > 0) { // print response
    //   buf_2[n] = '\0'; // add NUL terminator to received message
    //   printf("Received from server: %s", buf_2);
    // } else {
    //   break;
    // }
    do {
      conn.receive(from_server);
      if (from_server.tag == TAG_ERR) {
        std::cerr << from_server.data;
      }
    } while (from_server.tag != TAG_DELIVERY);

  //  std::cout << "received successfully" << std::endl;
   std::vector<std::string> message = from_server.split_payload();
  //  std::cout<<message.size() <<std::endl;
   std::cout << message[1] <<": " << message[2];
  }
  


  return 0;
}
