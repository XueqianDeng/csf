// C implementation of hexdump functions


#include <unistd.h>  // this is the only system header file you may include!
#include "hexfuncs.h"

/*
 * 
 */
unsigned hex_read(char data_buf[]) {
  //this line uses the ssize_t read (int filedes, void *buffer, size_t size)
  //function in the standard GNU C library. For file descriptor, 0=stdin and 
  // 2=stderr. 
  unsigned actual_number_of_bytes = read(0, *data_buf, 16);
  return actual_number_of_bytes;
}

// Write given nul-terminated string to standard output.
void hex_write_string(const char s[]){
  
}
