/* CSF Assignment 2
 * C implementation of hexdump functions
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include <unistd.h>  // this is the only system header file you may include!
#include "hexfuncs.h"

/*
 * This function is to read in from the standard in to the data buffer.
 * Parameters:
 *  data_buf - pointer to the data_buf string to keep the stdin input.
 * Returns:
 *  actual bytes that read in. 
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
