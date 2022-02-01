#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include <stdint.h>
#include "fixedpoint.h"
int main(){
    Fixedpoint val1 = fixedpoint_create_from_hex("--1!00f2");
    Fixedpoint val2 = fixedpoint_create_from_hex("f6a5865.00f2");
    printf("%lu\n%lu\n%d\n\n",val1.whole_part, val1.frac_part,val1.tag);
    printf("%lu\n%lu\n%d\n\n",val2.whole_part, val2.frac_part,val2.tag);
    printf("\n%d\n\n",fixedpoint_is_zero(val1));
    printf("\n%d\n\n",fixedpoint_is_zero(val2));
    // char str[]="1";
    // printf("%lu",strtoul(str,NULL,16)<<63);
}