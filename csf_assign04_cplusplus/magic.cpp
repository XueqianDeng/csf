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
  if(argc != 2) {
    std:cerr << "Not Enough Arguments \n";
    return 1;
  }
  int filedescriptor = open(argv[1], O_RDONLY);
  struct stat statistical_buffer;
  int reader_come = fstat(filedescriptor, &statistical_buffer);
  if(reader_come != 0) {
    std:cerr << "An error has occured\n";
    return 2;
  }
  uint32_t file_size = stat.st_size;
  void *data
}
