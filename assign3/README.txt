Xueqian Deng, Chujian Yu
 
<<<<<<< HEAD
Chujian Yu contribute to the helper methods and functionality of cache_funcs.cpp and cache_funcs.h. 
Xueqian Deng contribute to the main function. 

Chujian Yu and Xueqian Deng contributed equally in the tasks. 
=======

Both Xueqian and Chujian contributed equally to this assignment
>>>>>>>

Experimentation: 

----------
EXPERIMENT 1
fifo vs. lru

testing fifo with gcc.trace:
./csim 256 4 16 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314171
Load misses: 4026
Store hits: 188047
Store misses: 9439
Total cycles: 9685683

testing fifo with swim.trace:
./csim 256 4 16 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 9136793

testing lru with gcc.trace:
 ./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing lru with swim.trace:
./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993

Analysis: First, we will analyze the data with gcc.trace in experimenting lru and fifo cache.

----------
EXPERIMENT 2
direct-mapped, set-associative, and fully associative caches

testing direct-mapped with gcc.trace

testing set-associative with gcc.trace

testing fully associative caches with gcc.trace

testing direct-mapped with swim.trace

testing set-associative with swim.trace

testing fully associative caches with swim.trace
----------
EXPERIMENT 3
write-through vs. write-back

----------
EXPERIMENT 4
write-allocate vs. no-write-allocate

----------
EXPERIMENT 5
different number of sets

----------
EXPERIMENT 6
different number of blocks

----------
EXPERIMENT 7
different number of bytes

----------
