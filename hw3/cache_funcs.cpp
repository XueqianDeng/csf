#include "cache_funcs.h"
// unsigned num_sets; //arg1
//     unsigned num_blocks; //arg2
//     unsigned block_size; // arg3, number of bytes in each block
//     int allocation_decision; // arg4
//     int write_policy;   //arg5
//     int evict_policy;   //arg6

bool is_power_of_two(unsigned number){
    return ((number & (number - 1)) == 0) && (number != 0);
}

//TODO: method length
Parameters::Parameters(char* input[]){
    if (input[1][0] == '-' || input[2][0] == '-' || input[3][0] == '-') {
        throw std::invalid_argument("invalid argument for numerical parameter");
    }

    num_sets = strtoul(input[1], NULL, 10);
    num_blocks = strtoul(input[2], NULL, 10);
    block_size = strtoul(input[3], NULL, 10);

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

// unsigned num_sets; //arg1
//     unsigned num_blocks; //arg2
//     unsigned block_size; // arg3, number of bytes in each block
//     int allocation_decision; // arg4
//     int write_policy;   //arg5
//     int evict_policy;   //arg6
void Parameters::print_param(){
    std::cout << "num_sets: " << num_sets << std::endl;
    std::cout << "num_blocks: " << num_blocks << std::endl;
    std::cout << "block_size: " << block_size << std::endl;
    std::cout << "allocation_decision: " << (int)allocation_decision << std::endl;
    std::cout << "write_policy: " << (int)write_policy << std::endl;
    std::cout << "evict_policy: " << (int)evict_policy << std::endl;

}



unsigned decode_index(unsigned address){
    //To be implemented
    return address;
}