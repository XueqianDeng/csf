//Harry Yu cyu62@jhu.edu
//Xueqian Deng xdeng13@jhu.edu

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

  ASSERT(0xf6a5865UL == fixedpoint_whole_part(val1));

  ASSERT(0x00f2000000000000UL == fixedpoint_frac_part(val1));

  Fixedpoint val12 = fixedpoint_create_from_hex("-0");
  ASSERT(val12.tag == 1);
  ASSERT(val12.whole_part == 0x0UL);
  ASSERT(val12.frac_part == 0x0UL);

  Fixedpoint val22 = fixedpoint_create_from_hex("3.4");
  ASSERT(val22.tag == 1);
  ASSERT(val22.whole_part == 0x3UL);
  ASSERT(val22.frac_part == 0x4000000000000000UL);

  Fixedpoint val442 = fixedpoint_create_from_hex("2.5");
  ASSERT(val442.tag == 1);
  ASSERT(val442.whole_part == 0x2UL);
  ASSERT(val442.frac_part == 0x5000000000000000UL);

  Fixedpoint val992 = fixedpoint_create_from_hex("-1.7");
  ASSERT(val992.tag == -1);
  ASSERT(val992.whole_part == 0x1UL);
  ASSERT(val992.frac_part == 0x7000000000000000UL);

 Fixedpoint val232 = fixedpoint_create_from_hex("-0.4");
  ASSERT(val232.tag == -1);
  ASSERT(val232.whole_part == 0x0UL);
  ASSERT(val232.frac_part == 0x4000000000000000UL);

  Fixedpoint val12332 = fixedpoint_create_from_hex("0.8");
  ASSERT(val12332.tag == 1);
  ASSERT(val12332.whole_part == 0x0UL);
  ASSERT(val12332.frac_part == 0x8000000000000000UL);

  Fixedpoint val200 = fixedpoint_create_from_hex("-0");
  ASSERT(val200.tag == 1);
  ASSERT(val200.whole_part == 0x0UL);
  ASSERT(val200.frac_part == 0x0UL);

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

  ASSERT(0 == strcmp("-2", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-2"))));
  ASSERT(0 == strcmp("2.33", fixedpoint_format_as_hex(fixedpoint_create_from_hex("2.33"))));
  ASSERT(0 == strcmp("-3.9", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-3.9"))));
  ASSERT(0 == strcmp("-0.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-0.8"))));
  ASSERT(0 == strcmp("-93939123.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-93939123.8"))));
  ASSERT(0 == strcmp("bbbbb.8", fixedpoint_format_as_hex(fixedpoint_create_from_hex("bbbbb.8"))));
  ASSERT(0 == strcmp("-bbbbb.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-bbbbb.ffff"))));
  ASSERT(0 == strcmp("-1.ffff", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-1.ffff"))));
  ASSERT(0 == strcmp("-1.fddd", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-1.fddd"))));
  ASSERT(0 == strcmp("-238.98888", fixedpoint_format_as_hex(fixedpoint_create_from_hex("-238.98888"))));
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
  Fixedpoint lhs8 = fixedpoint_create2(0,1UL<<63);
  Fixedpoint rhs8 = fixedpoint_create2(__UINT64_MAX__,1UL<<63);
  Fixedpoint sum8 = fixedpoint_add(lhs8, rhs8);
  ASSERT(sum8.tag ==2);
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
}
