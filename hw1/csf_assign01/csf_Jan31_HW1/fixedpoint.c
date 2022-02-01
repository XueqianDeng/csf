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
  // TODO: implement
  Fixedpoint fp = {whole,0, 1};
  return fp;
}

Fixedpoint fixedpoint_create2(uint64_t whole, uint64_t frac) {
  // TODO: implement
  Fixedpoint fp = {whole,frac,1};
  return fp;
}
int find_unique_dot_index(const char * str){
  int count = 0, i = 0, idx = -1;
  for (; str[i]; i++){
    if(str[i] == '.'){
      if(count != 0) return -2; // more than one dot
      count++;
      idx = i;
    }
  }
  return idx;
}
//return -1 if invalid, 0 if valid and no decimal part, 1 if valid with decimal part
int is_valid_hex_string(const char *hex){ 
  int count = 0, i = 0;
  if (hex[0] == '-'){//if first character is a minus sign, skip it in the for loop
    i = 1;
  }
  for (; hex[i]; i++){
    if(hex[i] != '.' && !( (hex[i]>='A'&&hex[i]<='F')||(hex[i]>='a'&&hex[i]<='f')||(hex[i]>='0'&&hex[i]<='9')  ) ){
      return -1;
    }
    count += (hex[i] == '.'); //counts number of decimal points
  }
  if(count > 1){
    return -1;
  }
  if (count == 1){
    return 1;
  }
  return 0;
}
Fixedpoint fixedpoint_create_from_hex(const char *hex) {
  int i, count, padding = 0, is_negative = 0;
  uint64_t whole=0, frac=0;
  char * token;
  Fixedpoint fp = {whole,frac,0};

  if(strlen(hex)==0){
    return fp;
  }
  int return_code = is_valid_hex_string(hex);
  if (return_code == -1){
    fp.tag=0;
    return fp; //invalid, with tag defaulted to 0
  }

  if(hex[0] == 45){ // if a minus sign
    is_negative = 1;
    fp.tag=-1;
  }
  else{
    fp.tag=1;
  }

  int hex_len = strlen(hex);
  int dot_idx = find_unique_dot_index(hex);
  int whole_len = dot_idx + 1;
  int frac_len = hex_len - dot_idx;
  char* whole_str = NULL;
  char* frac_str= NULL;

  if (whole_len != 0){
    whole_str = malloc(whole_len);
    assert(whole_str);
    strncpy(whole_str,hex,whole_len-1);
    whole_str[whole_len-1] = 0; //null-terminated
  }
  if (frac_len != 0){
    frac_str = malloc(frac_len);
    assert(frac_str);
    strncpy(frac_str,&(hex[dot_idx+1]),frac_len-1);
    frac_str[frac_len-1]=0;
  }

  if(whole_str && frac_str == NULL){
    fp.tag=0;
    return fp;
  }
  if(whole_str){
    whole = strtoul(whole_str+is_negative,NULL,16); //skip minus sign if negative
    fp.whole_part=whole;
  }
  if(frac_str){
    assert(return_code == 1); // make sure there's only one decimal point
    frac=strtoul(frac_str,NULL,16);
    padding = (strlen(frac_str) ) *4;
    frac = frac << 64-padding;
    fp.frac_part=frac;
  }
  free(whole_str);
  free(frac_str);
  return fp;
}

uint64_t fixedpoint_whole_part(Fixedpoint val) {
  // TODO: implement
  return val.whole_part;
}

uint64_t fixedpoint_frac_part(Fixedpoint val) {
  // TODO: implement
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
  // TODO: implement
  assert(0);
  char *s = malloc(20);
  strcpy(s, "<invalid>");
  return s;
}
