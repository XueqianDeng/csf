#ifndef CACHE_FUNCS_H
#define CACHE_FUNCS_H

#include <cstring>
#include <vector>
#include <string>
#include <stdexcept>
#include <iostream>
enum class Param_type
{   
    no_write_allocate,
    write_allocate,
    write_back,
    write_through,
    lru,
    fifo
};

class Parameters{
    public:
    unsigned num_sets; //arg1
    unsigned num_blocks; //arg2
    unsigned block_size; // arg3, number of bytes in each block
    Param_type allocation_decision; // arg4
    Param_type write_policy;   //arg5
    Param_type evict_policy;   //arg6

    Parameters(char* input[]);

    void print_param();
};

class Statistics{
    public:
    unsigned total_loads;
    unsigned total_stores;
    unsigned load_hits;
    unsigned load_misses;
    unsigned store_hits;
    unsigned store_misses;
    unsigned total_cycles;
    
};


typedef struct slot {
    unsigned tag;
    unsigned load_ts;
    unsigned access_ts;
    bool valid;
    bool dirty;
} Slot;

typedef struct set {
    std::vector<Slot> slots;
    unsigned index;
} Set;

typedef struct cache {
    std::vector<Set> sets;
    Parameters * param;
    Statistics * stats;
} Cache;

unsigned decode_index(unsigned address);

#endif 