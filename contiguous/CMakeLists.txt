
add_executable(contig contiguous.F90)
if(f08contig)
  target_compile_definitions(contig PRIVATE ISCONTIG)
endif()

add_test(NAME Contiguous COMMAND contig)
