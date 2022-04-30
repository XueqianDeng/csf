#include "guard.h"
#include "message.h"
#include "message_queue.h"
#include "user.h"
#include "room.h"
#include <string>
#include <algorithm>

#include <iostream>

/*
 * To construct the room object with the string name of the room
 * 
 * Parameters:
 * room_name - the string of the room name
 */
Room::Room(const std::string &room_name)
  : room_name(room_name) {
  // initialize the mutex
  pthread_mutex_init(&lock, NULL);

}

Room::~Room() {
  // TODO: destroy the mutex
  pthread_mutex_destroy(&lock);
}

void Room::add_member(User *user) {
  // TODO: add User to the room
  pthread_mutex_lock(&lock);
  members.insert(user);
  pthread_mutex_unlock(&lock);
}

void Room::remove_member(User *user) {
  // TODO: remove User from the room
  pthread_mutex_lock(&lock);
  members.erase(user);
  pthread_mutex_unlock(&lock);
}


void Room::broadcast_message(const std::string &sender_username, const std::string &message_text) {
  // TODO: send a message to every (receiver) User in the room
  pthread_mutex_lock(&lock);
  for (User* u : members) {
    // if (u->username.compare(sender_username) == 0) {
    //   continue;
    // }
    std::string str = get_room_name() + ":"+sender_username + ":" + message_text;

    str.erase( std::remove(str.begin(), str.end(), '\n'), str.end() );
    str += "\n";
    Message *m = new Message(TAG_DELIVERY, str);
    u->mqueue.enqueue(m);
  }
  pthread_mutex_unlock(&lock);
}
