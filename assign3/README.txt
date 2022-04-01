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
direct-mapped, set-associative, and fully associative caches: cache size 16384 bytes

testing direct-mapped with gcc.trace
./csim 256 1 64 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 312297
Load misses: 5900
Store hits: 194064
Store misses: 3422
Total cycles: 21858083

testing set-associative with gcc.trace
./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing fully associative caches with gcc.trace
./csim 1 256 64 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 316383
Load misses: 1814
Store hits: 194867
Store misses: 2619
Total cycles: 12109283

testing direct-mapped with swim.trace
./csim 256 1 64 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218041
Load misses: 2627
Store hits: 78826
Store misses: 3699
Total cycles: 16415193

testing set-associative with swim.trace
 ./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993

testing fully associative caches with swim.trace
./csim 1 256 64 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 220127
Load misses: 541
Store hits: 79422
Store misses: 3103
Total cycles: 10944793

----------
EXPERIMENT 3
write-through vs. write-back

testing write-through with gcc.trace
./csim 256 4 16 write-allocate write-through lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 25318283

testing write-back with gcc.trace
./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing write-through with swim.trace
./csim 256 4 16 write-allocate write-through lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 13247693

testing write-back with swim.trace
./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993

----------
EXPERIMENT 4
write-allocate vs. no-write-allocate

testing write-allocate with gcc.trace
./csim 256 4 16 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314171
Load misses: 4026
Store hits: 188047
Store misses: 9439
Total cycles: 9685683

testing no-write-allocate with gcc.trace
./csim 256 4 16 no-write-allocate write-through fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 311017
Load misses: 7180
Store hits: 163705
Store misses: 33781
Total cycles: 23102502

testing write-allocate with swim.trace
./csim 256 4 16 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 9136793

testing no-write-allocate with swim.trace
./csim 256 4 16 no-write-allocate write-through fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 217968
Load misses: 2700
Store hits: 57994
Store misses: 24531
Total cycles: 9611162

----------
EXPERIMENT 5
different number of sets: 16384 bytes cache

testing 128 sets with gcc.trace
./csim 128 4 32 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 315101
Load misses: 3096
Store hits: 192511
Store misses: 4975
Total cycles: 11242883

testing 256 sets with gcc.trace
./csim 256 4 16 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314171
Load misses: 4026
Store hits: 188047
Store misses: 9439
Total cycles: 9685683

testing 128 sets with swim.trace
./csim 128 4 32 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219116
Load misses: 1552
Store hits: 76531
Store misses: 5994
Total cycles: 10642393

testing 256 sets with swim.trace
./csim 256 4 16 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 9136793
----------
EXPERIMENT 6
different number of blocks: 16384 bytes cache

testing 4 block with gcc.trace
./csim 256 4 16 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314171
Load misses: 4026
Store hits: 188047
Store misses: 9439
Total cycles: 9685683

testing 8 block with gcc.trace
./csim 256 8 8 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 312729
Load misses: 5468
Store hits: 179369
Store misses: 18117
Total cycles: 7686283

testing 4 block with swim.trace
./csim 256 4 16 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 9136793

testing 8 block with swim.trace
./csim 256 8 8 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 217539
Load misses: 3129
Store hits: 63712
Store misses: 18813
Total cycles: 5898593

----------
EXPERIMENT 7
different number of bytes

testing 16 bytes with gcc.trace
./csim 256 4 16 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314171
Load misses: 4026
Store hits: 188047
Store misses: 9439
Total cycles: 9685683

testing 64 bytes with gcc.trace
./csim 256 4 64 write-allocate write-back fifo < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 316802
Load misses: 1395
Store hits: 195030
Store misses: 2456
Total cycles: 9997283

testing 16 bytes with swim.trace 
./csim 256 4 16 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 9136793

testing 64 bytes with swim.trace
./csim 256 4 64 write-allocate write-back fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 220146
Load misses: 522
Store hits: 79428
Store misses: 3097
Total cycles: 9840793

----------
