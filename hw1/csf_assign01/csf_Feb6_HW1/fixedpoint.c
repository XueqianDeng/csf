/* CSF Assignment 1                                                                                                                
 * Harry Yu cyu62@jhu.edu                                                                                                          
 * Xueqian Deng xdeng13@jhu.edu                                                                                                   
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include "fixedpoint.h"
#include <stdbool.h>

//create fixedpoint with only the whole part
Fixedpoint fixedpoint_create(uint64_t whole) {
  Fixedpoint fp = {whole,0, 1}; //create a Fixedpoint struct, with tag defaulted to 1 (valid and non-negative)
  return fp;
}

//creat fixedpoint with both the whole and the frac part
Fixedpoint fixedpoint_create2(uint64_t whole, uint64_t frac) {
  Fixedpoint fp = {whole,frac,1}; //create a Fixedpoint struct, with tag defaulted to 1 (valid and non-negative)
  return fp;
}

//Returns index of decimal points, or -1 if not found decimal point, -2 if error
int find_unique_dot_index(const char * str){
  if(!str){
    return -2;
  }
  int count = 0, i = 0, idx = -1; //idx of decimal point defaulted to unfound(-1)
  for (; str[i]; i++){
    if(str[i] == '.'){
      if(count != 0) return -2; // if encountered more than one dot, return -2 indicating error
      count++; 
      idx = i; //set idx to the index of decimal point
    }
  }
  return idx;
}

//return -1 if invalid, 0 if valid with no decimal part, 1 if valid with decimal part
int is_valid_hex_string(const char *hex){ 
  if(!hex) {
    return -1;
  }
  int count = 0, i = 0;
  if (hex[0] == '-'){//if first character is a minus sign, skip the sign in the for loop
    i = 1;
  }
  for (; hex[i]; i++){
    if(hex[i] != '.' && !( (hex[i]>='A'&&hex[i]<='F')||(hex[i]>='a'&&hex[i]<='f')||(hex[i]>='0'&&hex[i]<='9')  ) ){
      return -1;
    }
    count += (hex[i] == '.'); //counts number of decimal points
  }
  if(count > 1){ //if count larger than 1, then invalid
    return -1;
  }
  if (count == 1){
    return 1;
  }
  return 0;
}

//create fixedpoint object from hexidecimal
Fixedpoint fixedpoint_create_from_hex(const char *hex) {
  int padding = 0, is_negative = 0;
  uint64_t whole=0, frac=0;
  Fixedpoint fp = {whole,frac,99};
  if(strlen(hex) == 0){
    return fp; //if empty string, return.
  }
  int return_code = is_valid_hex_string(hex); //check if valid
  if (return_code == -1){
    fp.tag=99;
    return fp; //invalid, with tag set to 0
  }
  if(hex[0] == 45){ // if starts with a minus sign
    is_negative = 1;
    fp.tag = -1;  //set tag
  }
  else{
    fp.tag = 1;
  }
  int hex_len = strlen(hex);  //get string length
  int dot_idx = find_unique_dot_index(hex);  //get index of decimal point
  int whole_len = dot_idx != -1 ? dot_idx-is_negative  : hex_len-is_negative;    //set length for whole part's string (+1 for null terminator)
  int frac_len = dot_idx != -1 ? hex_len - dot_idx - 1: 0; //set length for frac part's string
  char* whole_str = NULL;
  char* frac_str= NULL;
  if(whole_len > 16 || frac_len >16 ||(whole_len<=0 && frac_len <=0)){ //if 
    fp.tag = 99;
    return fp;
  }
  if (whole_len != 0){  //if contains whole part
    whole_str = malloc(whole_len+1);
    assert(whole_str);
    strncpy(whole_str,hex+is_negative,whole_len); //copy whole parts to the new string
    whole_str[whole_len] = 0; //null-terminated
    whole = strtoul(whole_str,NULL,16); //add is_negative to parse the parts without minus sign if any
    fp.whole_part = whole;
    free(whole_str);//deallocate memory
  }
  if (frac_len != 0){ //if contains frac part
    frac_str = malloc(frac_len+1);
    assert(frac_str);
    strncpy(frac_str,&(hex[dot_idx+1]),frac_len); //copy parts after the decimal point to the new string
    frac_str[frac_len]=0;
    assert(return_code == 1); // make sure there's at most only one decimal point
    frac=strtoul(frac_str,NULL,16);
    padding = (strlen(frac_str) ) *4;
    frac = frac << (64-padding); //left shift the frac part
    fp.frac_part=frac;
    free(frac_str);
  }
  if(whole == 0 && frac == 0) fp.tag=1;
  return fp;
}

//return the whole part of fixedpoint
uint64_t fixedpoint_whole_part(Fixedpoint val) {
  return val.whole_part;
}

//return the frac part of fixedpoint
uint64_t fixedpoint_frac_part(Fixedpoint val) {
  return val.frac_part;
}

// Compute the sum of two valid Fixedpoint values.
Fixedpoint fixedpoint_add(Fixedpoint left, Fixedpoint right) {
  Fixedpoint sum = {0,0,left.tag};
  if ( abs(left.tag)!=1 || abs(right.tag)!=1 ){ //if not valid input
    sum.tag = 0;
    return sum;
  }
  if (left.tag == right.tag){
    sum.whole_part = left.whole_part + right.whole_part; //this can detect overflow in 0xFFFF.FFFF + 0xFFFF.FFFF
    if(sum.whole_part < left.whole_part || sum.whole_part < right.whole_part) { //if the sum is smaller than either operands
      sum.tag = sum.tag*2; //overflow
      return sum;
    }
    sum.frac_part = left.frac_part + right.frac_part;
    if(sum.frac_part < left.frac_part || sum.frac_part < right.frac_part) { //determine if carrying is needed
      sum.whole_part++;
      }
    if(sum.whole_part < left.whole_part || sum.whole_part < right.whole_part) { //if the sum is smaller than either operands
      sum.tag = sum.tag*2; //overflow
      return sum;
    }
  }
  else{ //if different signs
    int borrowed = 0, left_is_greater = -1;
    if(left.whole_part >right.whole_part || (left.whole_part == right.whole_part && left.frac_part>right.frac_part) ){
      left_is_greater = 1; //find the one if larger absolute value; equal abs.vals will be handled below
    }
    sum.frac_part = left_is_greater*(left.frac_part - right.frac_part); //have the larger one minus the smaller one
    if((left_is_greater == 1 && sum.frac_part > left.frac_part) || ((left_is_greater == -1 && sum.frac_part > right.frac_part)) ){
      borrowed = 1;
    }
    sum.whole_part = left_is_greater*(left.whole_part - right.whole_part) - borrowed; //compute whole part; if borrowing happens, minus one
    if (sum.frac_part == 0 && sum.whole_part == 0) sum.tag = 1; //handle the case when abs.vals are the same
    else sum.tag = left_is_greater == 1 ? left.tag:right.tag; //set tag according to the operand that determines over the sign
  }
  return sum;
}

//perform fixedpoint subtraction 
Fixedpoint fixedpoint_sub(Fixedpoint left, Fixedpoint right) {
  //please note that since sub essentially calls add, the testing efforts for add largely supports sub.
  Fixedpoint right_negated = {right.whole_part,right.frac_part,-right.tag}; //negate the tag of the rhs
  return fixedpoint_add(left,right_negated);//use add function with negated rhs
}

//perform fixedpoint negation
Fixedpoint fixedpoint_negate(Fixedpoint val) {
  Fixedpoint fp = {val.whole_part, val.frac_part, fixedpoint_is_zero(val)? val.tag: -val.tag }; //must be valid and not zero to be negated; if is 0 or not valid, no changes are made
  return fp;
}

//divde fixedpoint by half
Fixedpoint fixedpoint_halve(Fixedpoint val) {
  int new_tag = (val.frac_part & 1) == 1 ? (val.tag)*3: val.tag; //if underflow, set tag to 3 or -3 to indicate
  Fixedpoint half = {val.whole_part >> 1, (val.frac_part >> 1) + ( (val.whole_part & 1) << 63), new_tag};
  return half;
}

//double fixedpoint
Fixedpoint fixedpoint_double(Fixedpoint val) {
  int new_tag = (val.whole_part>>63 & 1) == 1 ? (val.tag)*2: val.tag; //if overflow, set tag to 2 or -2
  Fixedpoint doubled = {(val.whole_part<< 1)+ ( (val.frac_part>>63) & 1 ), (val.frac_part << 1) , new_tag};
  return doubled;
}

//perform fixedpoint comparison
int fixedpoint_compare(Fixedpoint left, Fixedpoint right) {
  // Returns:
//    -1 if left < right;
//     0 if left == right;
//     1 if left > right
if (left.tag == right.tag){ // if they have the same tag, then compare values
  if(left.whole_part == right.whole_part && left.frac_part == right.frac_part){
    return 0;
  }
  else if(left.whole_part > right.whole_part || (left.whole_part == right.whole_part && left.frac_part > right.frac_part)){
    return left.tag == 1? 1:-1;
  }
  else return left.tag == 1? -1 : 1;
}
else if (left.tag > right.tag){ // if left is positive and right is negative, return 1;
    return 1;
  }
else return -1; //if left is negative and right is positive, return -1
}

// Returns:
//   1 if val is a valid Fixedpoint value equal to 0;
//   0 is val is not a valid Fixedpoint value equal to 0
int fixedpoint_is_zero(Fixedpoint val) {
   //if zero, it should be valid non-negative with both parts = 0
  int is_zero = (abs(val.tag == 1)) && (val.whole_part == 0 && val.frac_part == 0);
  return is_zero;
}

//return tag 99 if is in error
int fixedpoint_is_err(Fixedpoint val) {
  return val.tag==99;
}

//return tag -1 if is negative
int fixedpoint_is_neg(Fixedpoint val) {
  return (val.tag == -1);
}

//return tag -2 if negative overflow
int fixedpoint_is_overflow_neg(Fixedpoint val) {
  return val.tag==-2;
}

//return tag 2 if positive overflow
int fixedpoint_is_overflow_pos(Fixedpoint val) {
  return val.tag==2;
}

//return tag -3 if negative underflow
int fixedpoint_is_underflow_neg(Fixedpoint val) {
  return val.tag==-3;
}

//return tag 3 if positive underflow 
int fixedpoint_is_underflow_pos(Fixedpoint val) {
  return val.tag==3;
}

//check if the fixedpoint is valid
int fixedpoint_is_valid(Fixedpoint val) {
  return (abs(val.tag)==1);
}

//trims leading and trailing 0's (if has fraction part)                                                        
char* trim_zeros(char* str, int has_frac){ 
  while(str && *str == '0' && *(str+1) && *(str+1)!='.') str++; //move past leading 0's
  if (has_frac == 1){
    int i = strlen(str)-1;
    while(str && str[i] != '.' && str[i] == '0') i--; //reversely iterate the traiing 0's
    str[i+1] = 0; //null terminate the string before trailing 0's
  }
  return str;
}

//return the hexidecimal char of the fixedpoint.
char *fixedpoint_format_as_hex(Fixedpoint val) {
  int has_frac = val.frac_part != 0 ? 1 : 0;
  int has_minus_sign = val.tag == 1 ? 0 : 1; 
  int len = has_frac ? 32+1 : 16; //32+1 if has decimal point, otherwise 16
  char *str = (char*) malloc(len+1);
  str[len]  = 0;   //null-terminated
  sprintf(str,"%016lx",val.whole_part); //get hex string
  if(has_frac == 1){
    str[16]='.'; //add decimal point if needed
    sprintf(str+17,"%016lx",val.frac_part);
  }
  char* temp = trim_zeros(str,has_frac);  //"trim" all zeros from str
  char* trimmed_str  =(char*) malloc(strlen(temp)+1+has_minus_sign);
  strcpy(trimmed_str + has_minus_sign,temp); //copy the string and make space for the minus sign (if needed)
  if(has_minus_sign == 1) trimmed_str[0] = '-'; //add minus sign if needed
  free(str); //free original string
  return trimmed_str; 
}
