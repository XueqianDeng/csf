/*
 * Cache simulator
 * CSF Assignment 3
 * Chujian Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 * 
 */


#include <iostream>
#include <vector>
#include "cache_funcs.h"

int main(int argc, char* argv[]) {
  try{
    if (argc != 7) { // missing parameters
      throw std::invalid_argument("incorrect number of arguments");
    }
    Parameters * param = new Parameters(argv);
    Statistics * stats = new Statistics();
    unsigned num_offset_bits = log2(param->block_size);
    unsigned num_index_bits = log2(param->num_sets);
    if (num_offset_bits + num_index_bits >= 32){
      throw std::invalid_argument("exceeds number of bits");
    }
    std::string token;
    Cache cache = {std::vector<Set>(param->num_sets, {std::vector<Slot>()}), param, stats, 0};
    while (std::cin >> token){
      bool is_load = token.compare("l") == 0;
      std::cin >> token;
      unsigned addr = stoul(token, NULL, 16);
      std::cin >> token;
      addr  >>= num_offset_bits; //discard offset bits
      unsigned index = addr & ( (~0U) >> (32 - num_index_bits)); //find index bits
      addr  >>= num_index_bits; //discard index bits, leaving only tag bits
      unsigned tag = addr;
      if(param->num_sets == 1){ //account for special case when num_set == 1
        index = 0U; //set index to 0 to force it to access a single set 
      }
      if (is_load){
        cache.load_slot(tag, index);
      } 
      else { 
        cache.write_slot(tag,index);
      }
    }
    cache.print_stats();
  } catch(std::invalid_argument& e) {
      std::cerr << "error: "<<e.what() <<std::endl;
      return -1;
  }
}
