/* CSF Assignment 1
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include <stdio.h>
#include <stdlib.h>
#include "fixedpoint.h"
#include "tctest.h"

// Test fixture object, has some useful values for testing
typedef struct {
  Fixedpoint zero;
  Fixedpoint one;
  Fixedpoint one_half;
  Fixedpoint one_fourth;
  Fixedpoint large1;
  Fixedpoint large2;
  Fixedpoint max;
} TestObjs;

// functions to create and destroy the test fixture
TestObjs *setup(void);
void cleanup(TestObjs *objs);

// test functions
void test_whole_part(TestObjs *objs);
void test_frac_part(TestObjs *objs);
void test_create_from_hex(TestObjs *objs);
void test_format_as_hex(TestObjs *objs);
void test_negate(TestObjs *objs);
void test_add(TestObjs *objs);
void test_sub(TestObjs *objs);
void test_is_overflow_pos(TestObjs *objs);
void test_is_err(TestObjs *objs);
void test_halve(TestObjs *objs);
void test_compare(TestObjs *objs);
void test_fixedpoint_double(TestObjs *objs);
void test_fixedpoint_is_zero(TestObjs *objs);
void test_fixedpoint_is_neg(TestObjs *objs);
void test_fixedpoint_is_overflow_neg(TestObjs *objs);
void test_fixedpoint_is_overflow_pos(TestObjs *objs);
void testfixedpoint_is_underflow_neg(TestObjs *objs);
void testfixedpoint_is_underflow_pos(TestObjs *objs);
void testfixedpoint_is_valid(TestObjs *objs);

int main(int argc, char **argv) {
  // if a testname was specified on the command line, only that
  // test function will be executed
  if (argc > 1) {
    tctest_testname_to_execute = argv[1];
  }

  TEST_INIT();

  TEST(test_whole_part);
  TEST(test_frac_part);
  TEST(test_create_from_hex);
  TEST(test_format_as_hex);
  TEST(test_negate);
  TEST(test_add);
  TEST(test_sub);
  TEST(test_is_overflow_pos);
  TEST(test_is_err);
  // IMPORTANT: if you add additional test functions (which you should!),
  // make sure they are included here.  E.g., if you add a test function
  // "my_awesome_tests", you should add
  //
  //   TEST(my_awesome_tests);
  // here. This ensures that your test function will actually be executed.
  TEST(test_halve);
  TEST(test_compare);
  TEST(test_fixedpoint_double);
  TEST(test_fixedpoint_is_zero);
  TEST(test_fixedpoint_is_neg);
  TEST(test_fixedpoint_is_overflow_neg);
  TEST(test_fixedpoint_is_overflow_pos);
  TEST(testfixedpoint_is_underflow_neg);
  TEST(testfixedpoint_is_underflow_pos);
  TEST(testfixedpoint_is_valid);
  TEST_FINI();
}

//setting up
TestObjs *setup(void) {
  TestObjs *objs = malloc(sizeof(TestObjs));

  objs->zero = fixedpoint_create(0UL);
  objs->one = fixedpoint_create(1UL);
  objs->one_half = fixedpoint_create2(0UL, 0x8000000000000000UL);
  objs->one_fourth = fixedpoint_create2(0UL, 0x4000000000000000UL);
  objs->large1 = fixedpoint_create2(0x4b19efceaUL, 0xec9a1e2418UL);
  objs->large2 = fixedpoint_create2(0xfcbf3d5UL, 0x4d1a23c24fafUL);
  objs->max = fixedpoint_create2(0xFFFFFFFFFFFFFFFFUL, 0xFFFFFFFFFFFFFFFFUL);
  objs->max = fixedpoint_create2(0xFFFFFFFFFFFFFFFFUL, 0xFFFFFFFFFFFFFFFFUL);
  return objs;
}

//to clean up
void cleanup(TestObjs *objs) {
  free(objs);
}

//test the whole part is working or not 
void test_whole_part(TestObjs *objs) {
  ASSERT(0UL == fixedpoint_whole_part(objs->zero));
  ASSERT(1UL == fixedpoint_whole_part(objs->one));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_half));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_fourth));
  ASSERT(0x4b19efceaUL == fixedpoint_whole_part(objs->large1));
  ASSERT(0xfcbf3d5UL == fixedpoint_whole_part(objs->large2));
}

//test the fract part is working or not 
void test_frac_part(TestObjs *objs) {
  ASSERT(0UL == fixedpoint_frac_part(objs->zero));
  ASSERT(0UL == fixedpoint_frac_part(objs->one));
  ASSERT(0x8000000000000000UL == fixedpoint_frac_part(objs->one_half));
  ASSERT(0x4000000000000000UL == fixedpoint_frac_part(objs->one_fourth));
  ASSERT(0xec9a1e2418UL == fixedpoint_frac_part(objs->large1));
  ASSERT(0x4d1a23c24fafUL == fixedpoint_frac_part(objs->large2));
}

//test create from hex functionality
void test_create_from_hex(TestObjs *objs) {
  (void) objs;

  Fixedpoint val1 = fixedpoint_create_from_hex("f6a5865.00f2");

  ASSERT(fixedpoint_is_valid(val1));

  ASSERT(0xf6a5865UL == fixedpoint_whole_part(val1));

  ASSERT(0x00f2000000000000UL == fixedpoint_frac_part(val1));

  Fixedpoint val2 = fixedpoint_create_from_hex("-0");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0x0UL);
  ASSERT(val2.frac_part == 0x0UL);

  Fixedpoint val3 = fixedpoint_create_from_hex("3.4");
  ASSERT(val3.tag == 1);
  ASSERT(val3.whole_part == 0x3UL);
  ASSERT(val3.frac_part == 0x4000000000000000UL);

  Fixedpoint val4 = fixedpoint_create_from_hex("2.5");
  ASSERT(val4.tag == 1);
  ASSERT(val4.whole_part == 0x2UL);
  ASSERT(val4.frac_part == 0x5000000000000000UL);

  Fixedpoint val5 = fixedpoint_create_from_hex("-1.7");
  ASSERT(val5.tag == -1);
  ASSERT(val5.whole_part == 0x1UL);
  ASSERT(val5.frac_part == 0x7000000000000000UL);

 Fixedpoint val6 = fixedpoint_create_from_hex("-0.4");
  ASSERT(val6.tag == -1);
  ASSERT(val6.whole_part == 0x0UL);
  ASSERT(val6.frac_part == 0x4000000000000000UL);

  Fixedpoint val7 = fixedpoint_create_from_hex("0.8");
  ASSERT(val7.tag == 1);
  ASSERT(val7.whole_part == 0x0UL);
  ASSERT(val7.frac_part == 0x8000000000000000UL);

  Fixedpoint val8 = fixedpoint_create_from_hex("-0");
  ASSERT(val8.tag == 1);
  ASSERT(val8.whole_part == 0x0UL);
  ASSERT(val8.frac_part == 0x0UL);

  Fixedpoint valss2 = fixedpoint_create_from_hex(".2");
  ASSERT(valss2.tag == 1);
  ASSERT(valss2.whole_part == 0x0UL);
  ASSERT(valss2.frac_part == 0x2000000000000000UL);

  Fixedpoint valssssss2 = fixedpoint_create_from_hex("-0");
  ASSERT(valssssss2.tag == 1);
  ASSERT(valssssss2.whole_part == 0x0UL);
  ASSERT(valssssss2.frac_part == 0x0UL);

  Fixedpoint valee2 = fixedpoint_create_from_hex("-.2");
  ASSERT(valee2.tag == -1);
  ASSERT(valee2.whole_part == 0x0UL);
  ASSERT(valee2.frac_part == 0x2000000000000000UL);

  Fixedpoint v2al2 = fixedpoint_create_from_hex("2");
  ASSERT(v2al2.tag == 1);
  ASSERT(v2al2.whole_part == 0x2UL);
  ASSERT(v2al2.frac_part == 0x0UL);

  Fixedpoint vael2 = fixedpoint_create_from_hex("-2");
  ASSERT(vael2.tag == -1);
  ASSERT(vael2.whole_part == 0x2UL);
  ASSERT(vael2.frac_part == 0x0UL);

  Fixedpoint val1232 = fixedpoint_create_from_hex("-2222222222222222.1234567390abcdef");
  ASSERT(val1232.tag == -1);
  ASSERT(val1232.whole_part == 0x2222222222222222UL);
  ASSERT(val1232.frac_part == 0x1234567390abcdefUL);

  Fixedpoint val1d2 = fixedpoint_create_from_hex("-.3333333333333333");
  ASSERT(val1d2.tag == -1);
  ASSERT(val1d2.whole_part == 0x0UL);
  ASSERT(val1d2.frac_part == 0x3333333333333333UL);

  Fixedpoint valasdss2 = fixedpoint_create_from_hex("3333333333333333");
  ASSERT(valasdss2.tag == 1);
  ASSERT(valasdss2.frac_part == 0x0UL);
  ASSERT(valasdss2.whole_part == 0x3333333333333333UL);

  Fixedpoint valh2 = fixedpoint_create_from_hex("-3333333333333333");
  ASSERT(valh2.tag == -1);
  ASSERT(valh2.frac_part == 0x0UL);
  ASSERT(valh2.whole_part == 0x3333333333333333UL);

  Fixedpoint valgg2 = fixedpoint_create_from_hex("-333333333333333333333");
  ASSERT(fixedpoint_is_err(valgg2));

  Fixedpoint valdsf2 = fixedpoint_create_from_hex("1234567890abcdef1");
  ASSERT(fixedpoint_is_err(valdsf2));

  Fixedpoint val2rwc = fixedpoint_create_from_hex("1234567890abcgwwww");
  ASSERT(fixedpoint_is_err(val2rwc));

  Fixedpoint vqal2 = fixedpoint_create_from_hex("wwww2390abcgwwww");
  ASSERT(fixedpoint_is_err(vqal2));

  Fixedpoint vall2 = fixedpoint_create_from_hex("...90abcgwwww");
  ASSERT(fixedpoint_is_err(vall2));
}

//test format_as_hex functionality
void test_format_as_hex(TestObjs *objs) {
  char *s;
  
  s = fixedpoint_format_as_hex(objs->zero);
  ASSERT(0 == strcmp(s, "0"));
  free(s);

  s = fixedpoint_format_as_hex(objs->one);
  ASSERT(0 == strcmp(s, "1"));
  free(s);

  s = fixedpoint_format_as_hex(objs->one_half);
  ASSERT(0 == strcmp(s, "0.8"));
  free(s);

  s = fixedpoint_format_as_hex(objs->one_fourth);
  ASSERT(0 == strcmp(s, "0.4"));
  free(s);

  s = fixedpoint_format_as_hex(objs->large1);
  ASSERT(0 == strcmp(s, "4b19efcea.000000ec9a1e2418"));
  free(s);

  s = fixedpoint_format_as_hex(objs->large2);
  ASSERT(0 == strcmp(s, "fcbf3d5.00004d1a23c24faf"));
  free(s);
  
  //please note that these pointers are not free'd, but if freed there will not be memory leaks
  ASSERT(0 == strcmp("-2", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-2"))));
  ASSERT(0 == strcmp("2.33", fixedpoint_format_as_hex(fixedpoint_create_from_hex("2.33"))));
  ASSERT(0 == strcmp("-3.9", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-3.9"))));
  ASSERT(0 == strcmp("-0.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-0.8"))));
  ASSERT(0 == strcmp("-93939123.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-93939123.8"))));
  ASSERT(0 == strcmp("bbbbb.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("bbbbb.8"))));
  ASSERT(0 == strcmp("-bbbbb.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-bbbbb.ffff"))));
  ASSERT(0 == strcmp("-1.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-1.ffff"))));
  ASSERT(0 == strcmp("-1.fddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-1.fddd"))));
  ASSERT(0 == strcmp("-2111138.988", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-2111138.988"))));
  ASSERT(0 == strcmp("21111111233", fixedpoint_format_as_hex(fixedpoint_create_from_hex("21111111233"))));
  ASSERT(0 == strcmp("dddddddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("dddddddd"))));
  ASSERT(0 == strcmp("aaaaaaa", fixedpoint_format_as_hex(fixedpoint_create_from_hex("aaaaaaa"))));
  ASSERT(0 == strcmp("-ab123123123", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-ab123123123"))));
  ASSERT(0 == strcmp("-123123131.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-123123131.ffff"))));
  ASSERT(0 == strcmp("-1.fddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-1.fddd"))));
  ASSERT(0 == strcmp("-123123238.98888", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-123123238.98888"))));
  ASSERT(0 == strcmp("-238.98d888", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-238.98d888"))));
  ASSERT(0 == strcmp("-2213123", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-2213123"))));
  ASSERT(0 == strcmp("2dd.33", fixedpoint_format_as_hex(fixedpoint_create_from_hex("2dd.33"))));
  ASSERT(0 == strcmp("-3.9ddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-3.9ddd"))));
  ASSERT(0 == strcmp("-123123.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-123123.8"))));
  ASSERT(0 == strcmp("1112323123", fixedpoint_format_as_hex(fixedpoint_create_from_hex("1112323123"))));
  ASSERT(0 == strcmp("0", fixedpoint_format_as_hex(fixedpoint_create_from_hex("0"))));
  ASSERT(0 == strcmp("bb.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("bb.ffff"))));
  ASSERT(0 == strcmp("-5.dd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-5.dd"))));
  ASSERT(0 == strcmp("-3331.fddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-3331.fddd"))));
  ASSERT(0 == strcmp("-22111138.988", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-22111138.988"))));
  ASSERT(0 == strcmp("-21111111233", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-21111111233"))));
  ASSERT(0 == strcmp("-dddddddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-dddddddd"))));
  ASSERT(0 == strcmp("-aaaaaaa", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-aaaaaaa"))));
  ASSERT(0 == strcmp("-d123123123", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-d123123123"))));
  ASSERT(0 == strcmp("-d123123131.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-d123123131.ffff"))));
  ASSERT(0 == strcmp("-aaa1.fddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-aaa1.fddd"))));
  ASSERT(0 == strcmp("-aa123123238.98888", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-aa123123238.98888"))));
  ASSERT(0 == strcmp("-a238.98d888", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-a238.98d888"))));
}

//test the negation functionality
void test_negate(TestObjs *objs) {
  // none of the test fixture objects are negative
  ASSERT(!fixedpoint_is_neg(objs->zero));
  ASSERT(!fixedpoint_is_neg(objs->one));
  ASSERT(!fixedpoint_is_neg(objs->one_half));
  ASSERT(!fixedpoint_is_neg(objs->one_fourth));
  ASSERT(!fixedpoint_is_neg(objs->large1));
  ASSERT(!fixedpoint_is_neg(objs->large2));

  // negate the test fixture values
  Fixedpoint zero_neg = fixedpoint_negate(objs->zero);
  Fixedpoint one_neg = fixedpoint_negate(objs->one);
  Fixedpoint one_half_neg = fixedpoint_negate(objs->one_half);
  Fixedpoint one_fourth_neg = fixedpoint_negate(objs->one_fourth);
  Fixedpoint large1_neg = fixedpoint_negate(objs->large1);
  Fixedpoint large2_neg = fixedpoint_negate(objs->large2);

  // zero does not become negative when negated
  ASSERT(!fixedpoint_is_neg(zero_neg));

  // all of the other values should have become negative when negated
  ASSERT(fixedpoint_is_neg(one_neg));
  ASSERT(fixedpoint_is_neg(one_half_neg));
  ASSERT(fixedpoint_is_neg(one_fourth_neg));
  ASSERT(fixedpoint_is_neg(large1_neg));
  ASSERT(fixedpoint_is_neg(large2_neg));

  // magnitudes should stay the same
  ASSERT(0UL == fixedpoint_whole_part(objs->zero));
  ASSERT(1UL == fixedpoint_whole_part(objs->one));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_half));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_fourth));
  ASSERT(0x4b19efceaUL == fixedpoint_whole_part(objs->large1));
  ASSERT(0xfcbf3d5UL == fixedpoint_whole_part(objs->large2));
  ASSERT(0UL == fixedpoint_frac_part(objs->zero));
  ASSERT(0UL == fixedpoint_frac_part(objs->one));
  ASSERT(0x8000000000000000UL == fixedpoint_frac_part(objs->one_half));
  ASSERT(0x4000000000000000UL == fixedpoint_frac_part(objs->one_fourth));
  ASSERT(0xec9a1e2418UL == fixedpoint_frac_part(objs->large1));
  ASSERT(0x4d1a23c24fafUL == fixedpoint_frac_part(objs->large2));
}

//test add functionality and many other stuff
void test_add(TestObjs *objs) {
  (void) objs;
  Fixedpoint lhs, rhs, sum;
  //test different signs
  lhs = fixedpoint_create_from_hex("-c7252a193ae07.7a51de9ea0538c5");
  rhs = fixedpoint_create_from_hex("d09079.1e6d601");
  sum = fixedpoint_add(lhs, rhs);
  ASSERT(fixedpoint_is_neg(sum));
  ASSERT(0xc7252a0c31d8eUL == fixedpoint_whole_part(sum));
  ASSERT(0x5be47e8ea0538c50UL == fixedpoint_frac_part(sum));
  Fixedpoint lhs2 = fixedpoint_create_from_hex("d09079.1e6d601");
  Fixedpoint rhs2 = fixedpoint_create_from_hex("-c7252a193ae07.7a51de9ea0538c5");
  Fixedpoint sum2 = fixedpoint_add(lhs2, rhs2);
  ASSERT(fixedpoint_is_neg(sum2));
  ASSERT(0xc7252a0c31d8eUL == fixedpoint_whole_part(sum2));
  ASSERT(0x5be47e8ea0538c50UL == fixedpoint_frac_part(sum2));
  Fixedpoint lhs3 = fixedpoint_create_from_hex("-c7252a193ae07.7a51de9ea0538c5");
  Fixedpoint rhs3 = fixedpoint_create_from_hex("-d09079.1e6d601");
  Fixedpoint sum3 = fixedpoint_add(lhs3, rhs3);
  ASSERT(fixedpoint_is_neg(sum3));
  ASSERT(0xC7252A2643E80UL == fixedpoint_whole_part(sum3));
  ASSERT(0x98BF3EAEA0538C50UL == fixedpoint_frac_part(sum3));

  //test add zeros
  Fixedpoint lhs4 = fixedpoint_create_from_hex("0");
  Fixedpoint rhs4 = fixedpoint_create_from_hex("0");
  Fixedpoint sum4 = fixedpoint_add(lhs4, rhs4);
  ASSERT(!fixedpoint_is_neg(sum4));
  ASSERT(0UL == fixedpoint_whole_part(sum4));
  ASSERT(0UL == fixedpoint_frac_part(sum4));
  
  //test positive overflow
  Fixedpoint lhs5 = fixedpoint_create2(__UINT64_MAX__,(1UL<<63));
  Fixedpoint rhs5 = fixedpoint_create2(0,1UL<<63);
  Fixedpoint sum5 = fixedpoint_add(lhs5, rhs5);
  ASSERT(sum5.tag==2);
  ASSERT(0UL== fixedpoint_whole_part(sum5));
  ASSERT(0UL == fixedpoint_frac_part(sum5));

  //test negative overflow
  Fixedpoint lhs6 = fixedpoint_create2(__UINT64_MAX__,(1UL<<63));
  lhs6.tag=-1; //negate
  Fixedpoint rhs6 = fixedpoint_create2(0,1UL<<63);
  rhs6.tag=-1;
  Fixedpoint sum6 = fixedpoint_add(lhs6, rhs6);
  ASSERT(sum6.tag==-2);
  ASSERT(0UL== fixedpoint_whole_part(sum6));
  ASSERT(0UL == fixedpoint_frac_part(sum6));

  //test that they have the same whole part, but one has greater negative frac part
  Fixedpoint lhs7 = fixedpoint_create_from_hex("-0.02");
  Fixedpoint rhs7 = fixedpoint_create_from_hex("0.01");
  Fixedpoint sum7 = fixedpoint_add(lhs7, rhs7);
  ASSERT(sum7.tag==-1);
  ASSERT(0UL== fixedpoint_whole_part(sum7));
  ASSERT(0x0100000000000000UL == fixedpoint_frac_part(sum7));
  Fixedpoint lhs8 = fixedpoint_create2(0,1UL<<63);
  Fixedpoint rhs8 = fixedpoint_create2(__UINT64_MAX__,1UL<<63);
  Fixedpoint sum8 = fixedpoint_add(lhs8, rhs8);
  ASSERT(sum8.tag ==2);
  Fixedpoint lhs9 = fixedpoint_create_from_hex("-125");
  Fixedpoint rhs9 = fixedpoint_create_from_hex("125");
  Fixedpoint sum9 = fixedpoint_add(lhs9, rhs9);

  //check tag nonnegative
  ASSERT(sum9.tag==1); 
  ASSERT(0UL== fixedpoint_frac_part(lhs9));
  ASSERT(0UL== fixedpoint_frac_part(rhs9));
  ASSERT(0UL== fixedpoint_whole_part(sum9));
  ASSERT(0UL== fixedpoint_frac_part(sum9));
  Fixedpoint lhs10 = fixedpoint_create_from_hex("125");
  Fixedpoint rhs10 = fixedpoint_create_from_hex("-125");
  Fixedpoint sum10 = fixedpoint_add(lhs10, rhs10);
  //check tag nonnegative
  ASSERT(sum10.tag==1); 
  ASSERT(0UL== fixedpoint_whole_part(sum10));
  ASSERT(0UL== fixedpoint_frac_part(sum10));
}

//test the sub functionality
void test_sub(TestObjs *objs) {
  (void) objs;
  //please note that since sub essentially calls add, the testing efforts for add largely supports sub.
  Fixedpoint lhs, rhs, diff;

  lhs = fixedpoint_create_from_hex("-ccf35aa3a04a3b.b105");
  rhs = fixedpoint_create_from_hex("f676e8.58");
  diff = fixedpoint_sub(lhs, rhs);
  ASSERT(fixedpoint_is_neg(diff));
  ASSERT(0xccf35aa496c124UL == fixedpoint_whole_part(diff));
  ASSERT(0x0905000000000000UL == fixedpoint_frac_part(diff));

  Fixedpoint lhs1 = fixedpoint_create_from_hex("3");
  Fixedpoint rhs1 = fixedpoint_create_from_hex("3");
  Fixedpoint diff1 = fixedpoint_sub(lhs1,rhs1);
  Fixedpoint cor1 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(diff1,cor1)==0);

  Fixedpoint lhs2 = fixedpoint_create_from_hex("-0.dddddddddddd");
  Fixedpoint rhs2 = fixedpoint_create_from_hex("-0.dddddddddddd");
  Fixedpoint diff2 = fixedpoint_sub(lhs2,rhs2);
  Fixedpoint cor2 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(diff2,cor2)==0);

  Fixedpoint lhs3 = fixedpoint_create_from_hex("-0.3");
  Fixedpoint rhs3 = fixedpoint_create_from_hex("-0.2");
  Fixedpoint diff3 = fixedpoint_sub(lhs3,rhs3);
  Fixedpoint cor3 = fixedpoint_create_from_hex("-0.1");
  ASSERT(fixedpoint_compare(diff3,cor3)==0);
}

//test is_overflow_pos functionality
void test_is_overflow_pos(TestObjs *objs) {
  Fixedpoint sum;

  sum = fixedpoint_add(objs->max, objs->one);
  ASSERT(fixedpoint_is_overflow_pos(sum));

  sum = fixedpoint_add(objs->one, objs->max);
  ASSERT(fixedpoint_is_overflow_pos(sum));

  Fixedpoint negative_one = fixedpoint_negate(objs->one);

  sum = fixedpoint_sub(objs->max, negative_one);
  ASSERT(fixedpoint_is_overflow_pos(sum));
}

//test if the is_err functionality is working 
void test_is_err(TestObjs *objs) {
  (void) objs;

  // too many characters
  Fixedpoint err1 = fixedpoint_create_from_hex("88888888888888889.6666666666666666");
  ASSERT(fixedpoint_is_err(err1));

  // too many characters
  Fixedpoint err2 = fixedpoint_create_from_hex("6666666666666666.88888888888888889");
  ASSERT(fixedpoint_is_err(err2));

  // this one is actually fine
  Fixedpoint err3 = fixedpoint_create_from_hex("-6666666666666666.8888888888888888");
  ASSERT(fixedpoint_is_valid(err3));
  ASSERT(!fixedpoint_is_err(err3));

  // whole part is too large
  Fixedpoint err4 = fixedpoint_create_from_hex("88888888888888889");
  ASSERT(fixedpoint_is_err(err4));

  // fractional part is too large
  Fixedpoint err5 = fixedpoint_create_from_hex("7.88888888888888889");
  ASSERT(fixedpoint_is_err(err5));

  // invalid hex digits in whole part
  Fixedpoint err6 = fixedpoint_create_from_hex("123xabc.4");
  ASSERT(fixedpoint_is_err(err6));

  // invalid hex digits in fractional part
  Fixedpoint err7 = fixedpoint_create_from_hex("7.0?4");
  ASSERT(fixedpoint_is_err(err7));
}

//test if the halve functionality is working 
void test_halve(TestObjs *objs) {
  (void) objs;

  Fixedpoint val1, half1;

  val1 = fixedpoint_create_from_hex("f676e8.58");
  half1 = fixedpoint_halve(val1);
  ASSERT(half1.tag ==1);
  ASSERT(0xf676e8UL/2 == fixedpoint_whole_part(half1));
  ASSERT(0x5800000000000000UL/2 == fixedpoint_frac_part(half1));
  ASSERT(0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half1)));
  ASSERT(0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half1)));

  Fixedpoint val3 = fixedpoint_create_from_hex("-f676e8.58");
  Fixedpoint half3 = fixedpoint_halve(val3);
  ASSERT(half3.tag ==-1);
  ASSERT(0xf676e8UL/2 == fixedpoint_whole_part(half3));
  ASSERT(0x5800000000000000UL/2 == fixedpoint_frac_part(half3));
  ASSERT(0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half3)));
  ASSERT(0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half3)));
}

//test if the compare functionality is working 
void test_compare(TestObjs *objs) {
  (void) objs;

  Fixedpoint lhs1 = fixedpoint_create_from_hex("-0.1");
  Fixedpoint rhs1 = fixedpoint_create_from_hex("0.05");
  ASSERT(fixedpoint_compare(lhs1,rhs1)==-1);
  ASSERT(fixedpoint_compare(rhs1,lhs1)==1);
  Fixedpoint lhs2 = fixedpoint_create_from_hex("-2.1");
  Fixedpoint rhs2 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(lhs2,rhs2)==-1);
  ASSERT(fixedpoint_compare(rhs2,lhs2)==1);
  Fixedpoint lhs3 = fixedpoint_create_from_hex("0");
  Fixedpoint rhs3 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(lhs3,rhs3)==0);
  Fixedpoint lhs4 = fixedpoint_create2(__UINT64_MAX__,0);
  lhs4.tag=-1;
  Fixedpoint rhs4 = fixedpoint_create2(__UINT64_MAX__,0);
  ASSERT(fixedpoint_compare(lhs4,rhs4)==-1);
  Fixedpoint lhs5 = fixedpoint_create_from_hex("-0");
  Fixedpoint rhs5 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(lhs5,rhs5)==0);
  Fixedpoint lhs6 = fixedpoint_create_from_hex("2.c");
  Fixedpoint rhs6 = fixedpoint_create_from_hex("2.a");
  ASSERT(fixedpoint_compare(lhs6,rhs6)==1);
  Fixedpoint lhs7 = fixedpoint_create_from_hex("2.c");
  Fixedpoint rhs7 = fixedpoint_create_from_hex("-2.a");
  ASSERT(fixedpoint_compare(lhs7,rhs7)==1);
  Fixedpoint lhs8 = fixedpoint_create_from_hex("2.a");
  Fixedpoint rhs8 = fixedpoint_create_from_hex("2.c");
  ASSERT(fixedpoint_compare(lhs8,rhs8)==-1);
}

// test if the double functionality is working 
void test_fixedpoint_double(TestObjs *objs){
  (void) objs;
  
  Fixedpoint fis1 = fixedpoint_create_from_hex("0.2");
  Fixedpoint sec1 = fixedpoint_double(fis1);
  Fixedpoint cor1 = fixedpoint_create_from_hex("0.4");
  ASSERT(fixedpoint_compare(sec1,cor1)==0);

  Fixedpoint fis2 = fixedpoint_create_from_hex("2.2");
  Fixedpoint sec2 = fixedpoint_double(fis2);
  Fixedpoint cor2 = fixedpoint_create_from_hex("4.4");
  ASSERT(fixedpoint_compare(sec2,cor2)==0);

  Fixedpoint fis3 = fixedpoint_create_from_hex("3");
  Fixedpoint sec3 = fixedpoint_double(fis3);
  Fixedpoint cor3 = fixedpoint_create_from_hex("6");
  ASSERT(fixedpoint_compare(sec3,cor3)==0);

  Fixedpoint fis4 = fixedpoint_create_from_hex("0");
  Fixedpoint sec4 = fixedpoint_double(fis4);
  Fixedpoint cor4 = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_compare(sec4,cor4)==0);

  Fixedpoint fis5 = fixedpoint_create_from_hex("-0.2");
  Fixedpoint sec5 = fixedpoint_double(fis5);
  Fixedpoint cor5 = fixedpoint_create_from_hex("-0.4");
  ASSERT(fixedpoint_compare(sec5,cor5)==0);

  Fixedpoint fis6 = fixedpoint_create_from_hex("-2.2");
  Fixedpoint sec6 = fixedpoint_double(fis6);
  Fixedpoint cor6 = fixedpoint_create_from_hex("-4.4");
  ASSERT(fixedpoint_compare(sec6,cor6)==0);

  Fixedpoint fis8 = fixedpoint_create_from_hex("-d");
  Fixedpoint sec8 = fixedpoint_double(fis8);
  Fixedpoint cor8 = fixedpoint_create_from_hex("-1b");
  ASSERT(fixedpoint_compare(sec8,cor8));
}

//test if fixedpoint is zero function is working
void test_fixedpoint_is_zero(TestObjs *objs){
  (void) objs;
  Fixedpoint fis = fixedpoint_create_from_hex("0");
  ASSERT(fixedpoint_is_zero(fis));
}

//test if fixedpoint is negative function is working 
void test_fixedpoint_is_neg(TestObjs *objs){
  (void) objs;
  Fixedpoint fis = fixedpoint_create_from_hex("-6");
  ASSERT(fixedpoint_is_neg(fis));

  fis = fixedpoint_create_from_hex("-6.0");
  ASSERT(fixedpoint_is_neg(fis));

  fis = fixedpoint_create_from_hex("-0.6");
  ASSERT(fixedpoint_is_neg(fis));

  fis = fixedpoint_create_from_hex("-.6");
  ASSERT(fixedpoint_is_neg(fis));

  fis = fixedpoint_create_from_hex("-0.6666666666666666");
  ASSERT(fixedpoint_is_neg(fis));

  fis = fixedpoint_create_from_hex("-.6666666666666666");
  ASSERT(fixedpoint_is_neg(fis));
}

//test if fixedpoint is overflow neg is working 
void test_fixedpoint_is_overflow_neg(TestObjs *objs){
  (void) objs;

  Fixedpoint lhs2 = fixedpoint_create_from_hex("-FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs2 = fixedpoint_create_from_hex("-0000000000000000.0000000000000001");
  Fixedpoint sum2 = fixedpoint_add(lhs2, rhs2);
  ASSERT(fixedpoint_is_overflow_neg(sum2));
  ASSERT(!fixedpoint_is_valid(sum2));

  Fixedpoint lhs3 = fixedpoint_create_from_hex("-FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs3 = fixedpoint_create_from_hex("-0000000000000000.0000000000000001");
  Fixedpoint sum3 = fixedpoint_add(rhs3, lhs3);
  ASSERT(fixedpoint_is_overflow_neg(sum3));
  ASSERT(!fixedpoint_is_valid(sum3));

  Fixedpoint lhs5 = fixedpoint_create_from_hex("-FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs5 = fixedpoint_create_from_hex("-0000000000000000.0000000000000011");
  Fixedpoint sum5 = fixedpoint_add(rhs5, lhs5);
  ASSERT(fixedpoint_is_overflow_neg(sum5));
  ASSERT(!fixedpoint_is_valid(sum5));

  Fixedpoint lhs7 = fixedpoint_create_from_hex("-FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs7 = fixedpoint_create_from_hex("-0000000000000000.0000000000001001");
  Fixedpoint sum7 = fixedpoint_add(rhs7, lhs7);
  ASSERT(fixedpoint_is_overflow_neg(sum7));
  ASSERT(!fixedpoint_is_valid(sum7));
}

//test if fixedpoint is overflow pos function is working 
void test_fixedpoint_is_overflow_pos(TestObjs *objs){
  (void) objs;

  Fixedpoint lhs5 = fixedpoint_create_from_hex("FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs5 = fixedpoint_create_from_hex("0000000000000000.0000000100000001");
  Fixedpoint sum5 = fixedpoint_add(lhs5, rhs5);
  ASSERT(fixedpoint_is_overflow_pos(sum5));
  ASSERT(!fixedpoint_is_valid(sum5));
  
  Fixedpoint lhs7 = fixedpoint_create_from_hex("FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhs7 = fixedpoint_create_from_hex("100000000.001000000001");
  Fixedpoint sum7 = fixedpoint_add(rhs7, lhs7);
  ASSERT(fixedpoint_is_overflow_pos(sum7));
  ASSERT(!fixedpoint_is_valid(sum7));

  Fixedpoint lhse = fixedpoint_create_from_hex("FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint rhse = fixedpoint_create_from_hex("FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF");
  Fixedpoint sume = fixedpoint_add(rhse, lhse);
  ASSERT(fixedpoint_is_overflow_pos(sume));
  ASSERT(!fixedpoint_is_valid(sume));
}

//test if fixedpoint is underflow neg function is working
void testfixedpoint_is_underflow_neg(TestObjs *objs){
  (void) objs;
  
  Fixedpoint rhs4 = fixedpoint_create_from_hex("-0000000000000000.0000000000000003");
  Fixedpoint sum4 = fixedpoint_halve(rhs4);
  ASSERT(fixedpoint_is_underflow_neg(sum4));
  ASSERT(!fixedpoint_is_valid(sum4));

  Fixedpoint rhs5 = fixedpoint_create_from_hex("-0000000000000000.0000000000000005");
  Fixedpoint sum5 = fixedpoint_halve(rhs5);
  ASSERT(fixedpoint_is_underflow_neg(sum5));
  ASSERT(!fixedpoint_is_valid(sum5));

  Fixedpoint rhs6 = fixedpoint_create_from_hex("-0000000000000000.0000000000000007");
  Fixedpoint sum6 = fixedpoint_halve(rhs6);
  ASSERT(fixedpoint_is_underflow_neg(sum6));
  ASSERT(!fixedpoint_is_valid(sum6));

}

//test that if fixedpoint is underflow pos function is working 
void testfixedpoint_is_underflow_pos(TestObjs *objs){
  (void) objs;
  Fixedpoint rhs4 = fixedpoint_create_from_hex("0000000000000000.0000000000000003");
  Fixedpoint sum4 = fixedpoint_halve(rhs4);
  ASSERT(fixedpoint_is_underflow_pos(sum4));
  ASSERT(!fixedpoint_is_valid(sum4));
  
  Fixedpoint rhs5 = fixedpoint_create_from_hex("0000000000000000.0000000000000005");
  Fixedpoint sum5 = fixedpoint_halve(rhs5);
  ASSERT(fixedpoint_is_underflow_pos(sum5));
  ASSERT(!fixedpoint_is_valid(sum5));

  Fixedpoint rhs6 = fixedpoint_create_from_hex("0000000000000000.0000000000000007");
  Fixedpoint sum6 = fixedpoint_halve(rhs6);
  ASSERT(fixedpoint_is_underflow_pos(sum6));
  ASSERT(!fixedpoint_is_valid(sum6));
}

//test if the fixedpoint_is_valid function is working 
void testfixedpoint_is_valid(TestObjs *objs){
  (void) objs;
  Fixedpoint rhs5 = fixedpoint_create_from_hex("3");
  ASSERT(fixedpoint_is_valid(rhs5));
  Fixedpoint rhs3 = fixedpoint_create_from_hex("-1");
  ASSERT(fixedpoint_is_valid(rhs3));
}
