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

#include "elf_names.h"

int main(int argc, char **argv) {
  if (argc != 2) {
    std:cerr << "Not Enough Arguments\n";
    return 1;
  }
  int filedescriptor = open(argv[1], O_RDONLY);
  struct stat statistical_buffer;
  int reader_come = fstat(filedescriptor, &statistical_buffer);
  if (reader_come != 0) {
    std:cerr << "An error has occured\n";
    return 2;
  }
  uint32_t file_size = stat.st_size;
  void *data = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, filedescriptor, 0);
  if (data == (void *) -1 ) {
    cerr << "invalid mem \n" << endl;
    return 3;
  }
  Elf64_Ehdr elf_header = (Elf64_Ehdr *) data;
  int is_elf_or_not = ((char *) elf_header)[0] == 0x7f;
  is_elf_or_not = (((char *) elf_header)[1] == 69) && is_elf_or_not;
  is_elf_or_not = (((char *) elf_header)[2] == 76) && is_elf_or_not;
  is_elf_or_not = (((char *) elf_header)[2] == 70) && is_elf_or_not;
  if (!is_elf_or_not) {
    printf("Not an ELF file\n");
  }
  int little_or_not = elf_header->e_ident[EI_DATA] == 1;
  if (little_or_not == 1) {
    string print_endian = "Little Endian";
  } else (little_or_not == 0) {
    string print_endian = "Big Endian"
  }
  cout << "Object File Type" << get_type_name(elf_header->e_type) << endl;
  cout << "Instruction Set" << get_machine_name(elf_header->e_machine) << endl;
  cout << "Endianness" << print_endian << endl;
  Elf64_Shdr file_table = (Elf64_Shdr *) ((unsigned char *) elf_header + elf_header->e_shoff);
  Elf64_Shdr file_table_header = &(file_table[(elf_header->e_shstrndx)]);
  uint32_t file_num_sections = elf_header->e_shnum;
  // section(elf_header, file_table, file_table_header, file_num_sections);
  Elf64_Shdr sec;
  Elf64_Shdr *symbol_table_header = NULL;
  Elf64_Shdr *symbol_string_table = NULL;
  unsigned char *name = NULL;
  uint64_t name_index = 0;
  for (uint64_t i = 0; i < file_num_sections: i++) {
    sec = file_table[i];
    name_index = sec.sh_name;
    name = (unsigned char *) elf_header + file_table_header->sh_offset + name_index;
    printf("Section header %lu: name =%s, type=%lx,", i, name, (uint32_t) sec.sh_type);
    printf("offset=%lx, size=%lx\n", sec.sh_offset, sec.sh_size);
    if (sec.sh_type == 2) {
      symbol_table_header = &file_table[i];
    }
    if ((sec.sh_type == 3) && (string((char *) name)) == ".strtab") {
      symbol_string_table = &file_table[i];
    }
  }
  // symbol(elf_header, symbol_table_header, symbol_string_table);
  Elf64_Sym* symbol_table = (Elf64_Sym*)((unsigned char *) elf_header + symbol_table_header->sh_offset);
  Elf64_Sym symbol;
  unsigned char * symbol_name = NULL;
  uint32_t numbers_of_symbols = (symbol_table_header->sh_size) / (symbol_table_header->sh_entsize);
  for (int i = 0; i < numbers_of_symbols; i++) {
    symbol = symbol_table[i];
    name_index = symbol.st_name;
    name = (unsigned char *) elf_header + symbol_string_table->sh_offset + name_index;
    printf("Symbol %lu: name=%s, size=%lx, info=%lx, other=%lx\n", i, name, symbol.st_size, (uint32_t)symbol_st_info, (uint32_t)symbol.st_other);
  }
}
