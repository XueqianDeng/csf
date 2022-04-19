/*
 * Analyzing ELF files
 * CSF Assignment 4
 * Chujian Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 * 
 */

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdarg>
#include <cerrno>
#include <cstdint>
#include <elf.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/unistd.h>
#include <fcntl.h>
#include <iostream>

#include "elf_names.h"

/*
 * To check if the input file is a valid elf file
 *
 * Parameters:
 *   elf_header - the pointer to elf header
 *
 * Returns:
 *   true if it's a valid elf file, false otherwise
 */
bool is_valid_elf(Elf64_Ehdr * elf_header){
  if (elf_header == nullptr) {
    return false;
  }
  bool is_elf_or_not = ((char *) elf_header)[0] == 0x7f; // check if the header matches a valid elf file
  is_elf_or_not = (((char *) elf_header)[1] == 69) && is_elf_or_not;
  is_elf_or_not = (((char *) elf_header)[2] == 76) && is_elf_or_not;
  is_elf_or_not = (((char *) elf_header)[3] == 70) && is_elf_or_not;
  return is_elf_or_not;
}

/*
 * To get the endianness of a valid elf file
 *
 * Parameters:
 *   elf_header - the pointer to elf header
 *
 * Returns:
 *   a string containning the corresponding endianness of the valid elf file
 */
std::string get_endianness(Elf64_Ehdr * elf_header){
  int is_little = elf_header->e_ident[EI_DATA] == 1; //get the endianness
  std::string endianness;
  if (is_little == 1) { // 1 if little endian
    endianness = "Little endian";
  } 
  else if (is_little == 0) {
    endianness = "Big endian";
  }
  return endianness;
}

/*
 * Prints a header summary of the elf file
 *
 * Parameters:
 *   elf_header - the pointer to elf header
 *
 */
void print_summary(Elf64_Ehdr * elf_header){
  std::cout << "Object file type: " << get_type_name(elf_header->e_type) << std::endl;
  std::cout << "Instruction set: " << get_machine_name(elf_header->e_machine) << std::endl;
  std::cout << "Endianness: " << get_endianness(elf_header) << std::endl;
}

/*
 * Prints the details of each section
 *
 * Parameters:
 *   elf_header - the pointer to elf header
 *   symbol_table_header - a double pointer to the symbol table header
 *   symbol_string_table - a double pointer to the symbol string table
 *
 */
void print_section(Elf64_Ehdr * elf_header, Elf64_Shdr **symbol_table_header, Elf64_Shdr **symbol_string_table){
  Elf64_Shdr *file_table = (Elf64_Shdr *) ((unsigned char *) elf_header + elf_header->e_shoff); 
  Elf64_Shdr *file_table_header = &(file_table[(elf_header->e_shstrndx)]);
  uint64_t file_num_sections = elf_header->e_shnum;
  Elf64_Shdr sec;
  unsigned char *name = NULL;
  uint64_t name_index = 0;
  for (size_t i = 0; i < (size_t)file_num_sections; i++) {
    sec = file_table[i];
    name_index = sec.sh_name; // get the offset of the name string of the section in .shstrtab
    name = (unsigned char *) elf_header + file_table_header->sh_offset + name_index; //get name by offset calculation
    printf("Section header %lu: name=%s, type=%lx, ", i, name, (uint64_t) sec.sh_type);
    printf("offset=%lx, size=%lx\n", sec.sh_offset, sec.sh_size); //used %lx according to specification
    if (sec.sh_type == 2) {
      *symbol_table_header = &file_table[i];
    }
    if ((sec.sh_type == 3) && strcmp((char*)name,".strtab") == 0) {
      *symbol_string_table = &file_table[i];
    }
  }
}

/*
 * Prints the details of each symbol
 *
 * Parameters:
 *   elf_header - the pointer to elf header
 *   symbol_table_header - a pointer to the symbol table header
 *   symbol_string_table - a pointer to the symbol string table
 *
 */
void print_symbol(Elf64_Ehdr * elf_header, Elf64_Shdr *symbol_table_header, Elf64_Shdr *symbol_string_table){
  unsigned char *name = NULL;
  Elf64_Sym* symbol_table = (Elf64_Sym*)((unsigned char *) elf_header + symbol_table_header->sh_offset);
  Elf64_Sym symbol;
  uint64_t name_index = 0;
  //calculate number of symbols by diving the total size by entry size
  uint64_t numbers_of_symbols = (symbol_table_header->sh_size) / (symbol_table_header->sh_entsize); 
  for (uint64_t i = 0; i < numbers_of_symbols; i++) {
    symbol = symbol_table[i];
    name_index = symbol.st_name; //get the offset of the name string of the symbol (if not 0)
    name = (unsigned char *) elf_header + symbol_string_table->sh_offset + name_index; // get name by offset calculation
    printf("Symbol %lu: name=%s, size=%lx, ", i, name, symbol.st_size);
    printf("info=%lx, other=%lx\n", (uint64_t)symbol.st_info, (uint64_t)symbol.st_other);
  }
}


/*
 * The main function. 
 *
 * Parameters:
 *   argc - number of arguments
 *   argv - the argument vector
 *
 * Returns:
 *   0 if executed successfully, -1 if in error
 */
int main(int argc, char **argv) {
  if (argc != 2) {
    std::cerr << "Incorrect number of arguments\n";
    return -1;
  }
  int file_descriptor = open(argv[1], O_RDONLY);
  if (file_descriptor < 0) { //if fails to open file
    std::cerr << "file cannot be opened" << std::endl;
    return -1;
  }
  struct stat statistical_buffer;
  int reader_come = fstat(file_descriptor, &statistical_buffer);
  if (reader_come != 0) {
    std::cerr << "fstat failure" << std::endl;
    return -1;
  }
  uint32_t file_size = statistical_buffer.st_size; //get file size after fstat
  //create a private read-only mapping
  void *data = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, file_descriptor, 0);
  if (data == (void *) -1 ) { //if getting MAP_FAILED
    std::cerr << "failture when creating mapping" << std::endl;
    return -1;
  }
  Elf64_Ehdr *elf_header = (Elf64_Ehdr *) data; // casting it to a pointer to Elf64_Ehdr
  bool is_elf_or_not = is_valid_elf(elf_header); //inspect header to determine if valid elf file
  if (!is_elf_or_not) {
    std::cout << "Not an ELF file" << std::endl;
    return 0; //print to stdout and exit with 0
  }
  print_summary(elf_header);
  Elf64_Shdr *symbol_table_header = NULL;
  Elf64_Shdr *symbol_string_table = NULL;
  //pass in double pointer to function so we can change it in function
  print_section(elf_header, &symbol_table_header, &symbol_string_table); 
  print_symbol(elf_header, symbol_table_header, symbol_string_table);
  return 0;
}
