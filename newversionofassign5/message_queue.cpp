#include <cassert>
#include <ctime>
#include "message_queue.h"

  // pthread_mutex_t m_lock; // must be held while accessing queue
  // sem_t m_avail;
  // std::deque<Message *> m_messages;

MessageQueue::MessageQueue() {
  // TODO: initialize the mutex and the semaphore
//   BoundedQueue *bq = malloc(sizeof(BoundedQueue));
// bq->data = malloc(max_items * sizeof(void *));
// bq->max_items = max_items;
// bq->head = bq->tail = 0;
// sem_init(&bq->slots, 0, max_items);
// sem_init(&bq->items, 0, 0);
// pthread_mutex_init(&bq->lock, NULL);
  sem_init(&m_avail, 0, 0);
  pthread_mutex_init(&m_lock, NULL);



}

MessageQueue::~MessageQueue() {
  // TODO: destroy the mutex and the semaphore
  sem_destroy(&m_avail);
  pthread_mutex_destroy(&m_lock);

}

void MessageQueue::enqueue(Message *msg) {
  // TODO: put the specified message on the queue

  // sem_wait(m_messages.size() - m_avail);
  pthread_mutex_lock(&m_lock);
  m_messages.push_back(msg);
  pthread_mutex_unlock(&m_lock);
  sem_post(&m_avail);


  // be sure to notify any thread waiting for a message to be
  // available by calling sem_post
}

Message *MessageQueue::dequeue() {
  struct timespec ts;

  // get the current time using clock_gettime:
  // we don't check the return value because the only reason
  // this call would fail is if we specify a clock that doesn't
  // exist
  clock_gettime(CLOCK_REALTIME, &ts);

  // compute a time one second in the future
  ts.tv_sec += 1;

  // TODO: call sem_timedwait to wait up to 1 second for a message
  //       to be available, return nullptr if no message is available
  if (sem_timedwait(&m_avail, &ts) == -1) {
    return nullptr;
  }
  

  // TODO: remove the next message from the queue, return it
  pthread_mutex_lock(&m_lock);
  if (m_messages.empty()) {
    return nullptr;
  }
  Message *msg = m_messages.front();
  assert((void*) msg != nullptr);
  m_messages.pop_front();
  pthread_mutex_unlock(&m_lock);
  return msg;
}
