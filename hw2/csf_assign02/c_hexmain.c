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
    for (int i = 0; i < togo; i++) {
      hex_format_byte_as_hex
    }
    // this for loop will write the hex char
  }
}
