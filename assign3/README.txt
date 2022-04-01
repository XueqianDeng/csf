Xueqian Deng, Chujian Yu
 
Chujian Yu contributed to the helper methods and functionality of cache_funcs.cpp and cache_funcs.h. 
Xueqian Deng contributed to the main function and the fifo implementation and the experiment design.

Both Xueqian and Chujian contributed equally to this assignment

Experimentation: 

----------
EXPERIMENT 1
fifo vs. lru in set-associative cache (write-allocate write-back)

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


Analysis: 
First, we will analyze the data in experimenting set-associative caches (write-allocate write-back) with fifo or lru.
The aim of this experiment is to compare the efficiency of lru and fifo for set-associative caches (write-allocate write-back).
It is noted that lru exhibits a slightly lower miss rates for loads and stores, so it shows that in this case having 
the least recently used ones evicted would result in lower hit rates. Since in this case these are all write-allocate
 caches with the same block size, the penalty for store miss is basically the same for those,
that it first loads into the cache and modifies the value in the cache.
Since they have similar miss penalty, the ones (lru) with lower miss rates (and also fewer cycles) 
is better in this case for set-associative caches.

----------
EXPERIMENT 2
direct-mapped, set-associative, and fully associative caches (lru): cache size 16384 bytes

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


Analysis: 
The aim of this experiment is to compare the efficiency of direct-mapped, set-associative, and fully associative caches
(write-allocate write-back lru) all with a size of 16384 bytes. We controlled the total cache size to be the same.
It is noted that the 4-way set-associative cache has the least number of cycles, even though it has higher load and store miss rates
than the fully associative cache. This could be because the miss penalty for the set-associative cache is lower; for example, on a
load miss, the cache will bring an entire block into the cache from the memory, so the set-associative cache with a block size of 16
bytes is going to have a smaller penalty than the fully-associative and direct-mapped cache with a block size of 64 bytes.
For the two caches that have the same block size, i.e. the fully associative and direct-mapped caches, the fully
associative has fewer number of total cycles. The reason could be that the eviction policy lru is not used for the
direct-mapped cache, so it has no better choice of which block to evict; the fully associative one, however, can 
evict the least recently used block, which is more effective in the long run in this case, leading to lower miss rates.



----------
EXPERIMENT 3
write-through combined with write-allocate vs. write-back combined with write-allocate 

testing write-through and write-back in set-associative caches with gcc.trace
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


Analysis:
The aim of this experiment is to compare the efficiency of write-through and write-back in 4-way set-associative caches.
With the same miss rate, cache with write-back has fewer total cycles than the one with write-through. The reason could be that
for write through, writing directly to the memory everytime is costly compared with write-back in this case.
since write-allocate brings the relevant block into cache during a miss, it is more effective when there are subsequent
writes to the location and write-back modifies the value in cache, deferring modifications to the memory.
therefore, write-through overall costs more cycles in this case as it writes to the memory immediately.
write-back.




----------
EXPERIMENT 4
write-allocate combined with write-through vs. no-write-allocate combined with write-through

testing write-allocate lru with swim.trace
./csim 256 4 16 write-allocate write-through lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 13247693

testing no-write-allocate lru with swim.trace
./csim 256 4 16 no-write-allocate write-through lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218072
Load misses: 2596
Store hits: 58030
Store misses: 24495
Total cycles: 9569598

testing write-allocate fifo with swim.trace
./csim 256 4 16 write-allocate write-through fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218357
Load misses: 2311
Store hits: 71787
Store misses: 10738
Total cycles: 13775293

testing no-write-allocate fifo with swim.trace
./csim 256 4 16 no-write-allocate write-through fifo < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 217968
Load misses: 2700
Store hits: 57994
Store misses: 24531
Total cycles: 9611162


Analysis:
The aim of this experiment is to compare no-write-allocate combined with write-through 
and write-allocate combined with write-through for 4-way set-associative caches (write-through).
It is found that write-allocate has lower miss rates than no-write-allocate, but it costs more total cycles.
The reason could be that write-allocate brings the entire block into the cache, so it is more likely to result in hits than
no-write-allocate. However, since we are using write-through during a miss, write-allocate costs more cycles because
it brings the entire block into cache from memory each time during a miss and writes to the memory,
 whereas no-write-allocate doesn't load the entire block and writes straight to the memory, which means
 the miss penalty for write-allocate combined with write-through is greater. (fifo and lru are also tested
 here; not surprisingly, lru has lower hit rates and total cycles as before) Therefore, 
 no-write-allocate combined write-through costs fewer total cycles. The result of this experiment also implies that
 write-allocate and write-through is a less favorable combination.


----------
EXPERIMENT 5
write-allocate combined with write-back vs. no-write-allocate combined with write-through

testing write-allocate write-back lru with swim.trace
./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993

testing no-write-allocate write-through lru with swim.trace
./csim 256 4 16 no-write-allocate write-through lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218072
Load misses: 2596
Store hits: 58030
Store misses: 24495
Total cycles: 9569598

testing write-allocate write-back lru with gcc.trace
./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing no-write-allocate write-through lru with gcc.trace
./csim 256 4 16 no-write-allocate write-through lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 311613
Load misses: 6584
Store hits: 164819
Store misses: 32667
Total cycles: 22865216


Analysis:
The aim of this experiment is to compare no-write-allocate combined with write-through
and write-allocate combined with write-back. It is found that write-allocate combined with
write-back results in lower miss rates. During a write miss, bringing an entire block
from memory could be somewhat a costly penalty, but it is overall a smaller penalty if there are subsequent
writes to that block. So, write-allocate combined with write-back is a better choice in this case.


----------
EXPERIMENT 6
different number of sets and blocks per set: 16384 bytes set-associative cache

testing 128 sets with gcc.trace
./csim 128 8 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314908
Load misses: 3289
Store hits: 188278
Store misses: 9208
Total cycles: 9122083

testing 256 sets with gcc.trace
./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing 128 sets with swim.trace
./csim 128 8 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219540
Load misses: 1128
Store hits: 71954
Store misses: 10571
Total cycles: 8475193

testing 256 sets with swim.trace
./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993


Analysis:
The aim of this experiment is to compare the different efficiency of caches with 
different number of sets and blocks per set, but with the same block size and total size.
We controlled for the same block size to make sure it introduce additioanl biases.
It is found that the confiuration 256 4 16 results in fewer total cycles, possibly due to
a lower load miss rate (but it has higher store miss rate). The improvement, therefore, is contingent on
the ratio of load and write operations and is not significant.

----------
EXPERIMENT 7
different number of blocks per set: 16384 bytes cache

testing 4 block with gcc.trace
./csim 256 4 16 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 314798
Load misses: 3399
Store hits: 188250
Store misses: 9236
Total cycles: 9185283

testing 8 block with gcc.trace
./csim 256 8 8 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 313484
Load misses: 4713
Store hits: 179709
Store misses: 17777
Total cycles: 7348283

testing 8 block with gcc.trace
./csim 256 16 4 write-allocate write-back lru < gcc.trace

data:
Total loads: 318197
Total stores: 197486
Load hits: 312729
Load misses: 5468
Store hits: 169711
Store misses: 27775
Total cycles: 4619183

testing 4 block with swim.trace
./csim 256 4 16 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219507
Load misses: 1161
Store hits: 71956
Store misses: 10569
Total cycles: 8491993

testing 8 block with swim.trace
./csim 256 8 8 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 219112
Load misses: 1556
Store hits: 63941
Store misses: 18584
Total cycles: 5458793

testing 4 block with swim.trace
./csim 256 16 4 write-allocate write-back lru < swim.trace

data:
Total loads: 220668
Total stores: 82525
Load hits: 218925
Load misses: 1743
Store hits: 61610
Store misses: 20915
Total cycles: 3016593


Analysis:
The aim of this expriment is to test the effect of different block sizes and number of blocks per set
on the efficiency of cache. It is found that in this case a block size of 16 caused greater total cycles
but has lower miss rates. A block size of 16 implicates greater miss penalty each time it 
loads an entire block. For a block size of 4, even though it has greater miss rates, its miss penalty is smaller
so it has fewer total cycles. 
----------
EXPERIMENT 8
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

Analysis: As we can see, when the bytes in each block increase, we see a significant drop of the store misses and load misses in both the experimentation of the data gcc.trace and swim.trace. The rationality is very simple, when each block has more space, the cache could just keep those data rather than evict them. The conclusion of this experiment is that with more bytes, the cache would have fewer cache misses, and thus the cache could be faster with fewer cycles. 
----------
