// Unit tests for hex functions
// These tests should work for both your C implementations and your
// assembly language implementations

#include <stdio.h>
#include <stdlib.h>
#include "tctest.h"
#include "hexfuncs.h"

// test fixture object
typedef struct {
  char test_data_1[16];
} TestObjs;

// setup function (to create the test fixture)
TestObjs *setup(void) {
  TestObjs *objs = malloc(sizeof(TestObjs));
  strcpy(objs->test_data_1, "Hello, world!\n");
  return objs;
}

// cleanup function (to destroy the test fixture)
void cleanup(TestObjs *objs) {
  free(objs);
}

// Prototypes for test functions
void testFormatOffset(TestObjs *objs);
void testFormatByteAsHex(TestObjs *objs);
void testHexToPrintable(TestObjs *objs);
void testhex_write_string(TestObjs *objs);
void test_hex_read(TestObjs *objs);

int main(int argc, char **argv) {
  if (argc > 1) {
    tctest_testname_to_execute = argv[1];
  }

  TEST_INIT();

  TEST(testFormatOffset);
  TEST(testFormatByteAsHex);
  TEST(testHexToPrintable);
  TEST(testhex_write_string);
  TEST(test_hex_read);
  
  TEST_FINI();

  return 0;
}

//test format offset
void testFormatOffset(TestObjs *objs) {
  (void) objs; // suppress warning about unused parameter
  char buf[16];
  hex_format_offset(1L, buf);
  ASSERT(0 == strcmp(buf, "00000001"));
  
  char buf1[16]; 
  hex_format_offset(0x7b, buf1);
  ASSERT(0 == strcmp(buf1, "0000007b"));
  
  char buf2[16]; 
  hex_format_offset(0x20, buf2);
  ASSERT(0 == strcmp(buf2, "00000020"));
  
  char buf3[16]; 
  hex_format_offset(32, buf3);
  ASSERT(0 == strcmp(buf3, "00000020"));
  
  char buf4[16]; 
  hex_format_offset(48, buf3);
  ASSERT(0 == strcmp(buf4, "00000030"));
  
  char buf5[16]; 
  hex_format_offset(49, buf5);
  ASSERT(0 == strcmp(buf5, "00000030"));
  
  char buf6[16]; 
  hex_format_offset(1192722, buf6);
  ASSERT(0 == strcmp(buf6, "01192722"));

  char buf7[16]; 
  hex_format_offset(1192722, buf7);
  ASSERT(0 == strcmp(buf7, "01192722"));
  
  char buf8[16]; 
  hex_format_offset(1192722, buf8);
  ASSERT(0 == strcmp(buf8, "000087ba"));
}

//test format as byte
void testFormatByteAsHex(TestObjs *objs) {
  char buf[16];
  hex_format_byte_as_hex(objs->test_data_1[0], buf);
  ASSERT(0 == strcmp(buf, "48"));
}

//test printable
void testHexToPrintable(TestObjs *objs) {
  ASSERT('H' == hex_to_printable(objs->test_data_1[0]));
  ASSERT('.' == hex_to_printable(objs->test_data_1[13]));
  //this will test the untestable range
  ASSERT(0x2E == hex_to_printable(0x12));
  ASSERT(0x2E == hex_to_printable(0x11));
  ASSERT(0x2E == hex_to_printable(0x02));
  ASSERT(0x2E == hex_to_printable(0x13));
  ASSERT(0x2E == hex_to_printable(0x10));
  //this will test the testable range
  ASSERT('S' == hex_to_printable('S'));
  ASSERT('b' == hex_to_printable('b'));
  ASSERT('p' == hex_to_printable('p'));
  ASSERT('&' == hex_to_printable('&'));
  ASSERT('*' == hex_to_printable('*'));
  ASSERT('2' == hex_to_printable('2'));
  ASSERT('1' == hex_to_printable('1'));
  ASSERT(';' == hex_to_printable(';'));
  ASSERT(']' == hex_to_printable(']'));
  ASSERT(' ' == hex_to_printable(' '));
  ASSERT('#' == hex_to_printable('#'));
  ASSERT('a' == hex_to_printable('a'));
  ASSERT('0' == hex_to_printable('0'));
  ASSERT('%' == hex_to_printable('%'));
  ASSERT('@' == hex_to_printable('@'));
  ASSERT('C' == hex_to_printable('C'));
  ASSERT('>' == hex_to_printable('>'));
  ASSERT('K' == hex_to_printable('K'));
  ASSERT('R' == hex_to_printable('R'));
}

//test hex_write
void testhex_write_string(TestObjs *objs) {
  (void) objs; // suppress warning about unused parameter
  hex_write_string("Hello, World \n");
  hex_write_string("Yes, it's all right, this is a test for hex_write \n");
}

//test hex_read
void test_hex_read(TestObjs *objs) {
  (void) objs;
  hex_write_string("This is hex_read testing\n");
  hex_write_string("The program will once return everything(not too long) you type \n");
  char databuffer[100];
  hex_read(databuffer);
  hex_write_string(databuffer);
}
