Xueqian Deng, Chujian Yu
 
Chujian Yu contributed to functions of the connection and server implementation.
Xueqian Deng is responsible for designing and debugging the program and the style/syntax.

Both Xueqian and Chujian contributed equally to this assignment

---------------------------------------------------------

Eventually your report about how you implemented thread synchronization
in the server should go here

For the synchronization in message_queue, we initialized
semaphore and mutex in its constructor. 
In enqueue(), we first locked the mutex, then pushed back
the message to the deque, unlock mutex, and lastly used 
sem_post(&m_avail) to indicate one more message is 
available in the message_queue, since the process of adding a message
needs to be in a critical section so that it can be executed atomically
without the possibility of  losing message.
In dequeue(), we passed &m_avail(which indicates available msgs)
and &timespec to sem_timedwait so that it waits up to 1 second for a message.
If no message is available, sem_timedwait would return -1 and dequeue() will
return nullptr. Then we locked the mutex and remove the front message, and finally
unlock mutex. So we basically checked if there's any avialable message, and if there
is, the program will dequeue the message in a critical section.
In its destructor, we called sem_destroy and pthread_mutex_destroy.

In room.cpp, we also determined some critical sections since joining the room
at the same time could lead to unwanted results. In the add member function
we lock the mutex and add a user to the shared set, and finally unlock it,
so that only one process can add user to the shared data structure at 
each time. The same for removing member, except that adding to set is changed
to removing from set. In broadcast_message() we also used mutex to lock the
mutex before dequeuing the message queue because we want to prevent changes made
by other processes while we are reading/broadcasting the messages in another
process. In server.cpp where we add_or_create_room, we used Guard to lock mutex 
while accessing the shared data structure of rooms, and when
Guard goes out of scope as the function exits, mutex is unlocked




 