/*
 * Functions for Fixedpoint values operation
 * CSF Assignment 1
 * Chujian Yu, Xueqian Deng
 * cyu62@jh.edu, xdeng13@jh.edu
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include "fixedpoint.h"
#include <stdbool.h>

// You can remove this once all of the functions are fully implemented
static Fixedpoint DUMMY;

Fixedpoint fixedpoint_create(uint64_t whole) {
  Fixedpoint fp = {whole,0, 1}; //create a Fixedpoint struct, with tag defaulted to 1 (valid and non-negative)
  return fp;
}

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

Fixedpoint fixedpoint_create_from_hex(const char *hex) {
  int padding = 0, is_negative = 0;
  uint64_t whole=0, frac=0;
  Fixedpoint fp = {whole,frac,0};
  if(strlen(hex)==0) return fp; //if empty string, return. (tag defaulted to 0)
  int return_code = is_valid_hex_string(hex); //check if valid hex string
  if (return_code == -1){
    fp.tag=0;
    return fp; //invalid, with tag set to 0
  }
  if(hex[0] == 45){ // if starts with a minus sign
    is_negative = 1;
    fp.tag=-1;  //set tag
  }
  else{
    fp.tag=1;
  }
  int hex_len = strlen(hex);  //get string length
  int dot_idx = find_unique_dot_index(hex);  //get index of decimal point
  int whole_len = dot_idx + 1;    //set length for whole part's string (+1 for null terminator)
  int frac_len = hex_len - dot_idx; //set length for frac part's string
  if (whole_len -1 > 16 || frac_len -1 > 16 || (whole_len == 1 && frac_len == 1)){ //check for overflow or no digits
    fp.tag = 0;
    return fp;
  }
  char* whole_str = NULL;
  char* frac_str= NULL;
  if (whole_len != 0){  //if contains whole part
    whole_str = (char*) malloc(whole_len);
    assert(whole_str);
    strncpy(whole_str,hex,whole_len-1); //copy whole parts to the new string
    whole_str[whole_len-1] = 0; //null-terminated
    whole = strtoul(whole_str+is_negative,NULL,16); //add is_negative to parse the parts without minus sign if any
    fp.whole_part=whole;
  }
  if (frac_len != 0){ //if contains frac part
    frac_str = (char*)malloc(frac_len);
    assert(frac_str);
    strncpy(frac_str,&(hex[dot_idx+1]),frac_len-1); //copy parts after the decimal point to the new string
    frac_str[frac_len-1]=0;
    assert(return_code == 1); // make sure there's at most only one decimal point
    frac=strtoul(frac_str,NULL,16);
    padding = (strlen(frac_str) ) *4;
    frac = frac << 64-padding; //left shift
    fp.frac_part=frac;
  }
  free(whole_str);//deallocate memory
  free(frac_str);
  return fp;
}

uint64_t fixedpoint_whole_part(Fixedpoint val) {
  return val.whole_part;
}

uint64_t fixedpoint_frac_part(Fixedpoint val) {
  return val.frac_part;
}

Fixedpoint fixedpoint_add(Fixedpoint left, Fixedpoint right) {
  // TODO: implement
  assert(0);
  return DUMMY;
}

Fixedpoint fixedpoint_sub(Fixedpoint left, Fixedpoint right) {
  // TODO: implement
  assert(0);
  return DUMMY;
}

Fixedpoint fixedpoint_negate(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return DUMMY;
}

Fixedpoint fixedpoint_halve(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return DUMMY;
}

Fixedpoint fixedpoint_double(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return DUMMY;
}

int fixedpoint_compare(Fixedpoint left, Fixedpoint right) {
  // TODO: implement
  assert(0);
  return 0;
}

// Returns:
//   1 if val is a valid Fixedpoint value equal to 0;
//   0 is val is not a valid Fixedpoint value equal to 0
int fixedpoint_is_zero(Fixedpoint val) {
   //if zero, it should be valid non-negative with both parts = 0
  int is_valid = (val.tag == 1) && (val.whole_part == 0 && val.frac_part == 0);
  return is_valid;
}

int fixedpoint_is_err(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_neg(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_overflow_neg(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_overflow_pos(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_underflow_neg(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_underflow_pos(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

int fixedpoint_is_valid(Fixedpoint val) {
  // TODO: implement
  assert(0);
  return 0;
}

char *fixedpoint_format_as_hex(Fixedpoint val) {
  char *s = malloc(20);
  strcpy(s, "<invalid>");
}
