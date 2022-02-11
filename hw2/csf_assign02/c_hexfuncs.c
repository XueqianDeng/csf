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
  unsigned actual_number_of_bytes = read(0, data_buf, 16);
  return actual_number_of_bytes;
}

/*
 * Write given nul-terminated string to standard output.
 * Parameters:
 *  s - pointer to the s string to be the stdin output.
 */
void hex_write_string(const char s[]){
  // this uses ssize_t write (int filedes, const void *buffer, size_t size)
  // function for the standard GNU C library. 
  // STDOUT_FILENO file descriptor = 1
  // since write is a return function, we will keep an index to monitor the 
  // implementation of write. 
  unsigned operationmonitor = write(1, s, 16);
}

/*
 * Format a long value as an offset string consisting of exactly 8
 * hex digits.  The formatted offset is stored in sbuf, which must
 * have enough room for a string of length 8.
 * Parameters:
 *  offset - the number to offset the string.
 *  sbuf - the pointer for keeping the string. 
 */
void hex_format_offset(unsigned offset, char sbuf[]){
  // we cannot use sprintf, it's in the stdio library.
  unsigned contemporaryholderofoffset = offset; // we make a copy of offset in case of unwanted operation
  char *position = sbuf; // take the pointer of sbuf
  char[] tablet = "0123456789abcdef"; // for taking the character
  *position += 8; // shift 8 position
  *position = '\0'; // end the offset
  for (int i = 0; i < 8; i++) {
    unsigned currentbyteholder = contemporaryholderofoffset & 0xF;
    // in binary OxF is 0000..0001111, so it takes the last 4 bits of the unsigned
    contemporaryholderofoffset >>= 4;
    *position-- = tablet[currentbyteholder]; // shift leftward.
  }
}


/*
 * Format a byte value (in the range 0-255) as string consisting
 * of two hex digits.  The string is stored in sbuf.
 * Parameters:
 *  byteval - the byte value to be translated. 
 *  sbuf - the pointer for keeping the string. 
 */
void hex_format_byte_as_hex(unsigned char byteval, char sbuf[]){
  sbuf[1] = byteval & 0xF;
  byteval >>= 4;
  sbuf[0] = byteval & 0xF;
  byteval >>= 4;
}
