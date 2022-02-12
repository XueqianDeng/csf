/* CSF Assignment 2
 * C implementation of hexdump main function
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include "hexfuncs.h"  // this is the only header file which may be included!

int main(void) {
  char databuffer[16]; // this string to keep input data
  int togo = 1; // maintainence of while loop
  unsigned offsetcounter = 0; //number of hexidecimal offset
  
  while (togo) {
    togo = hex_read(databuffer);
    togo = togo <= 16 ? 1 : 0;
    // everytime there should be exact 16 read-in, unless the line ends 
    offsetcounter += 16;
    // note: up to requirements, the program runs only one time, instead runnning
    // until CTRL^D; until it reaches the end of statement.
    char offsetkeeper[16];
    hex_format_offset(offsetcounter, offsetkeeper);
    // hexidecimal offset is translated into offsetkeeper
    hex_write_string(offsetkeeper);
    // let's ouput the first 8 hex  
    hex_write_string(": ");
    // column and space before the ASCII code for each char
    char *databufferhexextractor1 = databuffer; // hex char counter
    char *databufferhexextractor2 = databuffer; // hex char counter
    int position = 0; // there are case that the line is not full.
    for (; position < togo; position++) {
      unsigned char byteval = *databufferhexextractor;
      databufferhexextractor++;
      // this shoud take out the character byte
      char bytevalkeep[2];
      // bytevalkeep is to keep the two bytes
      hex_format_byte_as_hex(byteval, bytevalkeep);
      hex_write_string(bytevalkeep);
      hex_write_string(" ");
      // this would print out the hex char of the character
    }
    // this for loop will write the hex char
    for(; position < 16; position++) {
      hex_write_string("   ");
    }
    // this is to make up the space if there is no 16 byte to write in the line
    hex_write_string("  ");
    // this is the end of writing hex char 
    for(; *databufferhexextractor2; databufferhexextractor++) {
      hex_write_string(hex_to_printable(databufferhexextractor2[0]) + "");
      //this should output the character if printable
    }
    hex_write_string("\n");
  }
  // I believe we are all set with this while loop
}
