/*
 * Cache functions for Cache simulator
 * CSF Assignment 3
 * Chujian Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 * 
 */

#include "cache_funcs.h"

/*
 * To check if it's a power of two or not. 
 *
 * Parameters:
 *   number - pointer to a C character string
 *
 * Returns:
 *   yes or no
 */
bool is_power_of_two(unsigned number){
    return ((number & (number - 1)) == 0) && (number != 0);
}


/*
 * To check if the input parameters given by the user 
 * of the main program is valid. 
 *
 * Parameters: input parameters of the main program.
 *   
 */
Parameters::Parameters(char* input[]):num_sets(strtoul(input[1], NULL, 10)), num_blocks(strtoul(input[2], NULL, 10)), block_size(strtoul(input[3], NULL, 10)){
    if (input[1][0] == '-' || input[2][0] == '-' || input[3][0] == '-') {
        throw std::invalid_argument("invalid argument for numerical parameter");
    }
    if (!is_power_of_two(num_sets) || !is_power_of_two(num_blocks) || block_size < 4){
        throw std::invalid_argument("invalid argument for numerical parameter");
    }
    if (strcmp(input[4], "write-allocate") == 0){
        allocation_decision = Param_type::write_allocate;
    }
    else if (strcmp(input[4], "no-write-allocate") == 0){
        allocation_decision = Param_type::no_write_allocate;
    }
    else{
        throw std::invalid_argument("invalid argument for write-allocate");
    }
    if (strcmp(input[5], "write-through") == 0){
        write_policy = Param_type::write_through;
    }
    else if (strcmp(input[5], "write-back") == 0){
        write_policy = Param_type::write_back;
    }
    else{
        throw std::invalid_argument("invalid argument for write policy");
    }
    if (strcmp(input[6], "lru") == 0){
        evict_policy = Param_type::lru;
    }
    else if (strcmp(input[6], "fifo") == 0){
        evict_policy = Param_type::fifo;
    }
    else{
        throw std::invalid_argument("invalid argument for lru or fifo");
    }
    if (write_policy == Param_type::write_back && allocation_decision == Param_type::no_write_allocate){
        throw std::invalid_argument("write_back conflicts with no_write_allocate");
    }
}


/*
 * This helper function is to print the parameters before 
 * printing the stats
 */
void Parameters::print_param(){
    std::cout << "num_sets: " << num_sets << std::endl;
    std::cout << "num_blocks: " << num_blocks << std::endl;
    std::cout << "block_size: " << block_size << std::endl;
    std::cout << "allocation_decision: " << (int)allocation_decision << std::endl;
    std::cout << "write_policy: " << (int)write_policy << std::endl;
    std::cout << "evict_policy: " << (int)evict_policy << std::endl;
}


/*
 * What this helper function does is that 
 * in a set given the set's index, 
 * find slot based on the tag
 *
 * Parameters:
 *   -tag the tag of the to find slot
 *   -index the index of the to find slot
 *
 * Returns:
 *   -it_slot the location of the slot that has the 
 *   -the tag and the index as inputs. 
 */
std::vector<Slot>::iterator Cache::find_slot(unsigned tag, unsigned index){
    // if (param->num_sets == 1) index = 0;
    auto pred = [tag](const Slot & slot) {
          return slot.tag == tag;
    };
    // find in the vector the slot containing the given tag
    std::vector<Slot>::iterator it_slot = std::find_if(sets[index].slots.begin(), sets[index].slots.end(), pred);
    return it_slot;
} 

/*
 * This helpher function does the evicting of 
 * the cache
 *
 * Parameters:
 *   -index the index of the current slot
 */
void Cache::evict(unsigned index){
    if (param->evict_policy == Param_type::lru){    
        auto cmp = [](const Slot& lhs, const Slot& rhs){
            return lhs.access_ts < rhs.access_ts; //compare access timestamp
        };
        // find in the slot with the smallest (oldest) timestamp
        std::vector<Slot>::iterator it_slot = std::min_element(sets[index].slots.begin(), sets[index].slots.end(), cmp);
        if (it_slot->dirty){ // if dirty, store to memory before evict
            // stats->total_stores += param->block_size/4;
            stats->total_cycles += param->block_size/4 * 100;
            // std::cout<< "dirty evicted" <<std::endl;
        }
        // std::cout<<"evicted: " << std::hex << it_slot->tag << std::dec << std::endl;
        sets[index].slots.erase(it_slot);
    }
    else {
        //TODO: to be implemented for fifo
        auto cmp = [](const Slot& lhs, const Slot& rhs){
            return lhs.load_ts < rhs.load_ts; //compare load timestamp
        };
        // find in the slot with the smallest (oldest) timestamp
        std::vector<Slot>::iterator it_slot = std::min_element(sets[index].slots.begin(), sets[index].slots.end(), cmp);
        if (it_slot->dirty){ // if dirty, store to memory before evict
            // stats->total_stores += param->block_size/4;
            stats->total_cycles += param->block_size/4 * 100;
            // std::cout<< "dirty evicted" <<std::endl;
        }
        // std::cout<<"evicted: " << std::hex << it_slot->tag << std::dec << std::endl;
        sets[index].slots.erase(it_slot);
    }
}

/*
 * This helpher function does loading of 
 * the cache
 *
 * Parameters:
 *   -index the index of the current slot
 *   -tag the tag of the slot
 */
void Cache::load_slot(unsigned tag, unsigned index){
    // find in the vector the slot containing the given tag
    stats->total_loads += 1;
    if (param->num_sets == 1) index = 0;
    std::vector<Slot>::iterator it_slot = param->num_blocks == 1 ? sets[index].slots.begin() : find_slot(tag, index);
    if ((param->num_blocks == 1 && sets[index].slots.size() == 1 && sets[index].slots[0].tag!=tag)|| it_slot == sets[index].slots.end()) { 
        // if no corresponding slot, add a new slot
        // std::cout<<"adding new slot: "<<std::hex << tag << std::dec<<std::endl;
        if (sets[index].slots.size() == param->num_blocks) {
            evict(index);
        }
        sets[index].slots.push_back({tag, timestamp, timestamp, true, false});
        stats->load_misses++;
        stats->total_cycles += param->block_size/4 * 100; //bring block from memory
        stats->total_cycles++; //load from cache to cpu
    }
    else {
        if (!it_slot->valid) { // if not valid bit
            stats->load_misses++;
            it_slot->access_ts = timestamp;
            it_slot->load_ts = timestamp;
            stats->total_cycles += param->block_size/4 * 100; //bring from memory
            stats->total_cycles++; //load from cache to cpu
            it_slot->valid = true;
        }
        else{
            stats->load_hits++;
            it_slot->access_ts = timestamp;
            stats->total_cycles++;
        }
    }
    timestamp++;
}

/*
 * This helpher function does writing of 
 * the cache
 *
 * Parameters:
 *   -index the index of the slot
 *   -tag the tag of the slot
 */
void Cache::write_slot(unsigned tag, unsigned index){
    // find in the vector the slot containing the given tag
    if (param->num_sets == 1) index = 0;
     std::vector<Slot>::iterator it_slot = find_slot(tag, index);
     stats->total_stores += 1;
    if (it_slot == sets[index].slots.end()){ // if a write miss
        if (param->allocation_decision == Param_type::write_allocate){
            // std::cout<<"writing loading new slot: "<<std::hex << tag << std::dec<<std::endl;
            write_alloc_miss(tag, index);
        }
        else {
            no_write_alloc_miss();
        }
    }
    else{ // if a write hit (found corresponding tag)
        if (param->write_policy == Param_type::write_back){
            write_back(it_slot);
        }
        else {
            write_through(it_slot);
        }
    }
    timestamp++;
}

/*
 * This helpher function does writing of 
 * the cache when allocation miss
 *
 * Parameters:
 *   -index the index of the slot
 *   -tag the tag of the slot
 */
void Cache::write_alloc_miss(unsigned tag, unsigned index){
    if (sets[index].slots.size() == param->num_blocks){
        evict(index);
    }
    sets[index].slots.push_back({tag, timestamp, timestamp, true, false});
    stats->store_misses++;
    stats->total_cycles +=  param->block_size/4 * 100; //load block from memory
    if (param->write_policy == Param_type::write_through) {
        stats->total_cycles += 100; //write to mem
        stats->total_cycles++; //store to cache
    }
    else { //write back
        stats->total_cycles++; //store to cache
    }
    timestamp++; 
}


/*
 * This helpher function does no writing of 
 * the cache when allocation miss
 */
void Cache::no_write_alloc_miss(){
    stats->store_misses++;
    stats->total_cycles += 100; //store to memory
    timestamp++;
}

/*
 * This helpher function does writing back
 * 
 * Parameters:
 *   -iterator to fid the slot
 */
void Cache::write_back(std::vector<Slot>::iterator it_slot){
    it_slot->access_ts = timestamp;
    it_slot->dirty = true;
    stats->store_hits++;
    stats->total_cycles++; 
    timestamp++;
}

/*
 * This helpher function does writing through
 * 
 * Parameters:
 *   -iterator to fid the slot
 */
void Cache::write_through(std::vector<Slot>::iterator it_slot){
    stats->store_hits++;
    stats->total_cycles++; //write to cache;
    it_slot->access_ts = timestamp; // update access timestamp
    stats->total_cycles += 100; // write to memory
    timestamp++;
}

/*
 * This helpher function prints the stats
 */
void Cache::print_stats(){
    std::cout << "Total loads: " << stats->total_loads << std::endl
    << "Total stores: " << stats->total_stores << std::endl
    << "Load hits: "    << stats->load_hits << std::endl
    << "Load misses: "    << stats->load_misses << std::endl
    << "Store hits: "   << stats->store_hits << std::endl
    << "Store misses: " << stats->store_misses << std::endl
    << "Total cycles: " << stats->total_cycles  << std::endl;
}







