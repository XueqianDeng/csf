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
  
}
