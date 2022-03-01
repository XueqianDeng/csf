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
  unsigned actual_number_of_bytes = 0;
  unsigned new_number_of_bytes = 0;
  do{
    new_number_of_bytes = read(0, data_buf + actual_number_of_bytes, 16 - actual_number_of_bytes);
    actual_number_of_bytes += new_number_of_bytes;
  } while (new_number_of_bytes != 0 && actual_number_of_bytes != 16);
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
  int null_terminator_finder = 0; 
  while (s[null_terminator_finder] != '\0') {
    null_terminator_finder += 1;
  }
  // find where is the null terminator
  unsigned operation_monitor = write(1, s, null_terminator_finder);
  if (operation_monitor == -1) {
    write(1, "ERROR", 6);
    // this if statement should never happen
  }
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
  unsigned contemporary_holder_offset = offset; // we make a copy of offset in case of unwanted operation
  char *position = sbuf; // take the pointer of sbuf
  char tablet[] = "0123456789abcdef"; // for taking the character
  int numberholder[8]; 
  for (int i = 0; i < 8; i++) {
    numberholder[i] = contemporary_holder_offset & 0xF;
    contemporary_holder_offset >>= 4;
  }
  // this for loop will take each digit of the offset into an int array
  for (int i = 0; i < 8; i++){
     *position = tablet[numberholder[7-i]];
     position++;
  }
  // this for loop push the int array into the string
  *position = '\0';
  // end the string by null terminator
}


/*
 * Format a byte value (in the range 0-255) as string consisting
 * of two hex digits.  The string is stored in sbuf.
 * Parameters:
 *  byteval - the byte value to be translated. 
 *  sbuf - the pointer for keeping the string. 
 */
void hex_format_byte_as_hex(unsigned char byteval, char sbuf[]){
  char tablet[] = "0123456789abcdef";
  sbuf[1] = tablet[byteval & 15]; // take off the value of the last 4 digit by 1111 binary
  byteval >>= 4;
  sbuf[0] = tablet[byteval & 15]; 
  sbuf[2] = '\0'; // mechanism as the previous function
}

/*
 * Convert a byte value (in the range 0-255) to a printable character
 * value.  If byteval is already a printable character, it is returned
 * unmodified.  If byteval is not a printable character, then the
 * ASCII code for '.' should be returned.
 *  byteval - the byte value to be translated.  
 */
char hex_to_printable(unsigned char byteval) {
  if (byteval < 0x20 || byteval > 0x7E) {
    byteval = 0x2E; // ASCII table
  }
  return byteval;
}
