/* CSF Assignment 2
 * C implementation of hexdump main function
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include "hexfuncs.h"  // this is the only header file which may be included!

int main(void) {
  char databuffer[]; // this string to keep input data
  int togo = 1; // maintainence of while loop
  unsigned offsetcounter = 0; //number of hexidecimal offset
  char stringbuffer[]; //formatted offset keeper
  
  while (togo) {
    togo = hex_read(databuffer); 
    // if not 0, then it's still reading; error should not happen if everthing is
    // correctly implemented. 
    offsetcounter += togo;
    // should be 16 bytes except the last line
    hex_format_offset(offsetcounter, stringbuffer);
    // hexidecimal offset is translated into stringbuffer
    hex_write_string(stringbuffer);
    // let's ouput the first 8 hex  
    hex_write_string(': ');
    // column and space before the ASCII code for each char
    int position = 0; // there are case that the line is not full.
    char *databufferhexextractor = databuffer; // hex char counter
    for (; position < togo; position++) {
      unsigned char byteval = databufferhexextractor[0];
      // this shoud take out the character byte
      stringbuffer = (stringbuffer | 0) & ('\0');
      // this should reset every in stringbuffer as 0
      // and a null terminator at the end. 
      hex_format_byte_as_hex(byteval, stringbuffer);
      hex_write_string(stringbuffer);
      hex_write_string(' ');
      // this would print out the hex char of the character
    }
    // this for loop will write the hex char
    for(; position < 16; position++) {
      hex_write_string('   ');
    }
    // this is to make up the space if there is no 16 byte to write in the line
    hex_write_string('  ');
    // this is the end of writing hex char 
    for(; *databufferhexextractor; databufferhexextractor++) {
      hex_write_string(hex_to_printable(databufferhexextractor[0]));
      //this should output the character if printable
    }
  }
  // I believe we are all set with this while loop
}
