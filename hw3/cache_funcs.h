#ifndef CACHE_FUNCS_H
#define CACHE_FUNCS_H

#include <cstring>
#include <vector>
#include <string>


typedef struct parameters {
    unsigned num_sets;
    unsigned num_blocks;
    unsigned block_size; // number of bytes in each block
    bool is_write_allocate;
    bool is_write_through;
    bool is_write_back;
    bool is_lru;
    bool is_fifo;
} Parameters;




typedef struct statistics {
    unsigned total_loads;
    unsigned total_stores;
    unsigned load_hits;
    unsigned load_misses;
    unsigned store_hits;
    unsigned store_misses;
    unsigned total_cycles;
} Statistics;

typedef struct slot {
    unsigned tag;
    unsigned load_ts;
    unsigned access_ts;
    bool valid;
    bool dirty;
} Slot;

typedef struct set {
    std::vector<Slot> slots;
} Set;

typedef struct cache {
    std::vector<Set> sets;
    Parameters param;
    Statistics stats;
} Cache;

unsigned decode_index(unsigned address);

#endif 