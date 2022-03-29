CC = g++
CONSERVATIVE_FLAGS = -std=c++11 -Wall -Wextra -pedantic
DEBUGGING_FLAGS = -g -O0
CFLAGS = $(CONSERVATIVE_FLAGS) $(DEBUGGING_FLAGS)
  
csim : main.o cache_funcs.o
	$(CC) -o csim main.o cache_funcs.o

main.o : main.cpp;
	$(CC) -c main.cpp $(CFLAGS)

cache_funcs.o : cache_funcs.cpp cache_funcs.h
	$(CC) -c cache_funcs.cpp $(CFLAGS)

.PHONY: clean all
clean:
	rm -f *.o csim
