/*
 * Cache functions for Cache simulator
 * CSF Assignment 3
 * Chujian Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 * 
 */


#ifndef CACHE_FUNCS_H
#define CACHE_FUNCS_H

#include <cstring>
#include <vector>
#include <string>
#include <stdexcept>
#include <iostream>
#include <math.h>
#include <algorithm>

/*
* The class enum for parameter types
*
*/
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

    /*
    * To check if the input parameters given by the user 
    * of the main program is valid. 
    *
    * Parameters: 
    *   input - input parameters of the program from command line arguments
    *   
    */
    Parameters(char* input[]);


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
};

struct Cache {
    std::vector<Set> sets;
    Parameters * param;
    Statistics * stats;
    unsigned timestamp;

    /*
    * Performs a load on a given slot in a given set
    *
    * Parameters:
    *   tag: the tag of the slot of interest
    *   index: the index of the set in which a slot is to be loaded
    *   
    */
    void load_slot(unsigned, unsigned);

    /*
    * Performs a write on a given slot in a given set
    *
    * Parameters:
    *   tag: the tag of the slot of interest
    *   index: the index of the set in which a slot is to be loaded
    *   
    */
    void write_slot(unsigned, unsigned);

    /*
    * Evicts a slot in a given set depending on the eviction policy (fifo or lru)
    *
    * Parameters:
    *   index: the index of the current set in which a slot will be evicted
    */
    void evict(unsigned);


    /*
    * Performs a write_allocate on a set during a write miss and updates relevant stats.
    *
    * Parameters:
    *   tag: the tag of the slot
    *   index: the index of the set
    *   
    */
    void write_alloc_miss(unsigned, unsigned);

    /*
    * Performs a no_write_allocate during a write miss. Does not
    * require slot to be given because it is only responsible for
    * updating the relevant stats.
    * 
    */
    void no_write_alloc_miss();

    /*
    * Performs a write_back on a given slot and updates relevant stats
    * 
    * Parameters:
    *   std::vector<Slot>::iterator it_slot: the iterator pointing to the target slot
    */
    void write_back(std::vector<Slot>::iterator);

    /*
    * Performs a write_through on a given slot and updates relevant stats
    * 
    * Parameters:
    *   std::vector<Slot>::iterator it_slot: the iterator pointing to the target slot
    */
    void write_through(std::vector<Slot>::iterator);


    /*
    * Finds the slot based on the tag in
    * a set with a given index
    *
    * Parameters:
    *   tag: the tag of the slot to be found
    *   index: the index of the set where the slot is to be searched for
    *
    * Returns:
    *   std::vector<Slot>::iterator: the iterator pointing to the slot found in 
    *       the given set; it is equal to slots.end() if unfound.
    */
    std::vector<Slot>::iterator find_slot(unsigned, unsigned);

    /*
    * Prints the statistics of the cache
    *
    */
    void print_stats();
    
};


/*
 * To check if a number is a power of two or not. 
 *
 * Parameters:
 *   number - unsigned number to be checked
 *
 * Returns:
 *   true if the number is a power of two, false otherwise
 */
bool is_power_of_two(unsigned number);





#endif 