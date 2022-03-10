CC = g++
CONSERVATIVE_FLAGS = -std=c++11 -Wall -Wextra -pedantic
DEBUGGING_FLAGS = -g -O0
CFLAGS = $(CONSERVATIVE_FLAGS) $(DEBUGGING_FLAGS)

main.o: main.cpp
	$(CC) -c main.cpp $(CFLAGS)

.PHONY: clean all
clean:
	rm -f *.o chess
