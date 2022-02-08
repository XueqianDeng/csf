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

  // TODO: add more objects to the test fixture
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
// TODO: add more test functions

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
  //
  // here. This ensures that your test function will actually be executed.
  TEST(test_halve);
  TEST(test_compare);
  TEST_FINI();
}

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

void cleanup(TestObjs *objs) {
  free(objs);
}

void test_whole_part(TestObjs *objs) {
  ASSERT(0UL == fixedpoint_whole_part(objs->zero));
  ASSERT(1UL == fixedpoint_whole_part(objs->one));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_half));
  ASSERT(0UL == fixedpoint_whole_part(objs->one_fourth));
  ASSERT(0x4b19efceaUL == fixedpoint_whole_part(objs->large1));
  ASSERT(0xfcbf3d5UL == fixedpoint_whole_part(objs->large2));
}

void test_frac_part(TestObjs *objs) {
  ASSERT(0UL == fixedpoint_frac_part(objs->zero));
  ASSERT(0UL == fixedpoint_frac_part(objs->one));
  ASSERT(0x8000000000000000UL == fixedpoint_frac_part(objs->one_half));
  ASSERT(0x4000000000000000UL == fixedpoint_frac_part(objs->one_fourth));
  ASSERT(0xec9a1e2418UL == fixedpoint_frac_part(objs->large1));
  ASSERT(0x4d1a23c24fafUL == fixedpoint_frac_part(objs->large2));
}

void test_create_from_hex(TestObjs *objs) {
  (void) objs;

  Fixedpoint val1 = fixedpoint_create_from_hex("f6a5865.00f2");

  ASSERT(fixedpoint_is_valid(val1));
  //TODO: write this

  ASSERT(0xf6a5865UL == fixedpoint_whole_part(val1));

  ASSERT(0x00f2000000000000UL == fixedpoint_frac_part(val1));

  Fixedpoint val2 = fixedpoint_create_from_hex("-0");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 0);

  Fixedpoint val2 = fixedpoint_create_from_hex("3.4");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 3);
  ASSERT(val2.frac_part == 4);

  Fixedpoint val2 = fixedpoint_create_from_hex("2.5");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 2);
  ASSERT(val2.frac_part == 5);

  Fixedpoint val2 = fixedpoint_create_from_hex("-1.7");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 1);
  ASSERT(val2.frac_part == 7);

 Fixedpoint val2 = fixedpoint_create_from_hex("-0.4");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 4);

  Fixedpoint val2 = fixedpoint_create_from_hex("0.8");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 8);

  Fixedpoint val2 = fixedpoint_create_from_hex("-0");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 0);

  Fixedpoint val2 = fixedpoint_create_from_hex(".2");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 2);

  Fixedpoint val2 = fixedpoint_create_from_hex("-0");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 0);

  Fixedpoint val2 = fixedpoint_create_from_hex("-.2");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 2);

  Fixedpoint val2 = fixedpoint_create_from_hex("2");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 2);
  ASSERT(val2.frac_part == 0);

  Fixedpoint val2 = fixedpoint_create_from_hex("-2");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 2);
  ASSERT(val2.frac_part == 0);

  Fixedpoint val2 = fixedpoint_create_from_hex("1234567890abcdef.1234567390abcdef");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 1234567890abcdef);
  ASSERT(val2.frac_part == 1234567390abcdef);

  Fixedpoint val2 = fixedpoint_create_from_hex("-2222222222222222.1234567390abcdef");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 2222222222222222);
  ASSERT(val2.frac_part == 1234567390abcdef);

  Fixedpoint val2 = fixedpoint_create_from_hex("-.3333333333333333");
  ASSERT(val2.tag == -1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 3333333333333333);

  Fixedpoint val2 = fixedpoint_create_from_hex(".3333333333333333");
  ASSERT(val2.tag == 1);
  ASSERT(val2.whole_part == 0);
  ASSERT(val2.frac_part == 3333333333333333);

  Fixedpoint val2 = fixedpoint_create_from_hex("3333333333333333");
  ASSERT(val2.tag == 1);
  ASSERT(val2.frac_part == 0);
  ASSERT(val2.whole_part == 3333333333333333);

  Fixedpoint val2 = fixedpoint_create_from_hex("-3333333333333333");
  ASSERT(val2.tag == -1);
  ASSERT(val2.frac_part == 0);
  ASSERT(val2.whole_part == 3333333333333333);

  Fixedpoint val2 = fixedpoint_create_from_hex("-333333333333333333333");
  ASSERT(fixedpoint_is_err(val2));

  Fixedpoint val2 = fixedpoint_create_from_hex("1234567890abcdef1");
  ASSERT(fixedpoint_is_err(val2));

  Fixedpoint val2 = fixedpoint_create_from_hex("1234567890abcgwwww");
  ASSERT(fixedpoint_is_err(val2));

  Fixedpoint val2 = fixedpoint_create_from_hex("wwww2390abcgwwww");
  ASSERT(fixedpoint_is_err(val2));

  Fixedpoint val2 = fixedpoint_create_from_hex("...90abcgwwww");
  ASSERT(fixedpoint_is_err(val2));
}

void test_format_as_hex(TestObjs *objs) {
  //TODO: add test more negative values for negative signs
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
}

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

void test_add(TestObjs *objs) {
  (void) objs;

  Fixedpoint lhs, rhs, sum;

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
  Fixedpoint lhs4 = fixedpoint_create_from_hex("0");
  Fixedpoint rhs4 = fixedpoint_create_from_hex("0");
  Fixedpoint sum4 = fixedpoint_add(lhs4, rhs4);
  ASSERT(!fixedpoint_is_neg(sum4));
  ASSERT(0UL == fixedpoint_whole_part(sum4));
  ASSERT(0UL == fixedpoint_frac_part(sum4));
  Fixedpoint lhs5 = fixedpoint_create2(__UINT64_MAX__,(1UL<<63));
  Fixedpoint rhs5 = fixedpoint_create2(0,1UL<<63);
  Fixedpoint sum5 = fixedpoint_add(lhs5, rhs5);
  ASSERT(sum5.tag==2);
  ASSERT(0UL== fixedpoint_whole_part(sum5));
  ASSERT(0UL == fixedpoint_frac_part(sum5));
  Fixedpoint lhs6 = fixedpoint_create2(__UINT64_MAX__,(1UL<<63));
  lhs6.tag=-1;
  Fixedpoint rhs6 = fixedpoint_create2(0,1UL<<63);
  rhs6.tag=-1;
  Fixedpoint sum6 = fixedpoint_add(lhs6, rhs6);
  ASSERT(sum6.tag==-2);
  ASSERT(0UL== fixedpoint_whole_part(sum6));
  ASSERT(0UL == fixedpoint_frac_part(sum6));
  Fixedpoint lhs7 = fixedpoint_create_from_hex("-0.02");//test that they have the same whole part, but one has greater negative frac part
  Fixedpoint rhs7 = fixedpoint_create_from_hex("0.01");
  Fixedpoint sum7 = fixedpoint_add(lhs7, rhs7);
  ASSERT(sum7.tag==-1);
  ASSERT(0UL== fixedpoint_whole_part(sum7));
  ASSERT(0x0100000000000000UL == fixedpoint_frac_part(sum7));
  Fixedpoint lhs8 = fixedpoint_create2(0,2UL<<63);
  Fixedpoint rhs8 = fixedpoint_create2(__UINT64_MAX__,1UL<<63);
  rhs8.tag=-1;
  Fixedpoint sum8 = fixedpoint_add(lhs8, rhs8);
  // ASSERT(sum8.tag==-2);
  // ASSERT(0UL== fixedpoint_whole_part(sum8));
  // ASSERT(0x0100000000000000UL == fixedpoint_frac_part(sum8));
  Fixedpoint lhs9 = fixedpoint_create_from_hex("-125");
  Fixedpoint rhs9 = fixedpoint_create_from_hex("125");
  Fixedpoint sum9 = fixedpoint_add(lhs9, rhs9);
  ASSERT(sum9.tag==1); //check tag nonnegative
  ASSERT(0UL== fixedpoint_frac_part(lhs9));
  ASSERT(0UL== fixedpoint_frac_part(rhs9));
  ASSERT(0UL== fixedpoint_whole_part(sum9));
  ASSERT(0UL== fixedpoint_frac_part(sum9));
  Fixedpoint lhs10 = fixedpoint_create_from_hex("125");
  Fixedpoint rhs10 = fixedpoint_create_from_hex("-125");
  Fixedpoint sum10 = fixedpoint_add(lhs10, rhs10);
  ASSERT(sum10.tag==1); //check tag nonnegative
  ASSERT(0UL== fixedpoint_whole_part(sum10));
  ASSERT(0UL== fixedpoint_frac_part(sum10));
}


void test_sub(TestObjs *objs) {
  (void) objs;

  Fixedpoint lhs, rhs, diff;

  lhs = fixedpoint_create_from_hex("-ccf35aa3a04a3b.b105");
  rhs = fixedpoint_create_from_hex("f676e8.58");
  diff = fixedpoint_sub(lhs, rhs);
  ASSERT(fixedpoint_is_neg(diff));
  ASSERT(0xccf35aa496c124UL == fixedpoint_whole_part(diff));
  ASSERT(0x0905000000000000UL == fixedpoint_frac_part(diff));
}

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

// TODO: implement more test functions
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


  Fixedpoint val2 = fixedpoint_create_from_hex("1.0000000000000001");
  Fixedpoint half2 = fixedpoint_halve(val2);
  // ASSERT(half2.tag ==3);

  Fixedpoint val3 = fixedpoint_create_from_hex("-f676e8.58");
  Fixedpoint half3 = fixedpoint_halve(val3);
  ASSERT(half3.tag ==-1);
  ASSERT(0xf676e8UL/2 == fixedpoint_whole_part(half3));
  ASSERT(0x5800000000000000UL/2 == fixedpoint_frac_part(half3));
  ASSERT(0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half3)));
  ASSERT(0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half3)));
}

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

  // Fixedpoint val3 = fixedpoint_create_from_hex("-f676e8.58");
  // Fixedpoint half3 = fixedpoint_halve(val3);
  // ASSERT(half3.tag ==-1);
  // ASSERT(0xf676e8UL/2 == fixedpoint_whole_part(half3));
  // ASSERT(0x5800000000000000UL/2 == fixedpoint_frac_part(half3));
  // ASSERT(0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half3)));
  // ASSERT(0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half3)));
}
