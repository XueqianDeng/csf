#include <iostream>
#include <vector>
#include "cache_funcs.h"
#include <math.h>
#include <algorithm>

int main(int argc, char* argv[]) {
  if (argc != 7) { // missing parameters
    return 0;
  }
  Parameters * param = new Parameters(argv);
  param->print_param();
  Statistics * stats = new Statistics();

  unsigned num_offset_bits = log2(param->block_size);
  unsigned num_index_bits = log2(param->num_sets);
  unsigned num_tag_bits = 32 - num_offset_bits - num_index_bits;
  if (num_offset_bits + num_index_bits >= 32){
    throw std::exception();
  }
  std::string token;
  
  unsigned timestamp = 0;
  Cache cache = {std::vector<Set>(), param, stats};

  while (std::cin >> token){
    bool is_load = token.compare("l");
    std::cin >> token;
    unsigned addr = stoul(token, NULL, 16);
    std::cin >> token;
    
    addr  >>= num_offset_bits; //discard offset bits
    unsigned index = addr & ( (~0U) >> (32 - num_index_bits)); //find index bits
    addr  >>= num_index_bits; //discard index bits, leaving only tag bits
    unsigned tag = addr;

    // std::cout << std::hex << index;
    // std::cout << std::endl;
    // std::cout << std::hex << tag;
    // std::cout << std::endl;

    if (is_load){ 
      auto pred = [index](const Set & set) { //predicate to find the set with given index in a vector
        return set.index == index;
      };
      // find in the vector the set containing the given index
      std::vector<Set>::iterator it_set = std::find_if(cache.sets.begin(), cache.sets.end(), pred);
      if (it_set == cache.sets.end()) {
        Slot slot = {tag, timestamp, timestamp, true, false};
        cache.sets.push_back({std::vector<Slot>(1,slot), index});
        stats->load_misses++;
        stats->total_loads += param->block_size/4;
      }
      else {
        auto pred = [tag](const Slot & slot) {
          return slot.tag == tag;
        };
        // find in the vector the slot containing the given tag
        std::vector<Slot>::iterator it_slot = std::find_if(it_set->slots.begin(), it_set->slots.end(), pred);
        if (it_slot == it_set->slots.end()) { // if no corresponding slot
          Slot slot = {tag, timestamp, timestamp, true, false};
          it_set->slots.push_back(slot);
          stats->load_misses++;
          stats->total_loads += param->block_size/4;
        }
        else { // if found the slot
                //TODO: check if it is full
        }
      }

    } 
    else { // if store

    }

  }

}
