#ifndef CACHE_FUNCS_H
#define CACHE_FUNCS_H

#include <cstring>
#include <vector>
#include <string>
#include <stdexcept>
#include <iostream>
#include <math.h>
#include <algorithm>

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


struct Slot {
    unsigned tag;
    unsigned load_ts;
    unsigned access_ts;
    bool valid;
    bool dirty;


    
};

struct Set {
    std::vector<Slot> slots;

    // void add_slot(unsigned tag, unsigned load_ts, unsigned access_ts, bool valid, bool dirty);
    // void add_new_slot(Slot);
};

struct Cache {
    std::vector<Set> sets;
    Parameters * param;
    Statistics * stats;
    unsigned timestamp;
    void append_new_set(std::vector<Slot>, unsigned);
    void load_slot(unsigned, unsigned);
    void write_slot(unsigned, unsigned);
    void write_slot_miss();
    void write_slot_hit();
    void evict(unsigned);
    void write_alloc_miss(unsigned, unsigned);
    void no_write_alloc_miss();
    void write_back(std::vector<Slot>::iterator);
    void write_through();
    void stats_to_mem(bool);
    void stats_to_cache(bool);
    std::vector<Slot>::iterator find_slot(unsigned, unsigned);
    void print_stats();
    
};

unsigned decode_index(unsigned);


#endif 