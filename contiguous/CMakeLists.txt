
add_executable(contig contiguous.F90)
if(f08contig)
  target_compile_definitions(contig PRIVATE ISCONTIG)
endif()
if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  target_compile_options(contig PRIVATE -Warray-temporaries)
endif()

if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  message(STATUS "SKIP: contiguous Intel Fortran on Windows only seems to have a bug with the contiguous program")
else()
  add_test(NAME Contiguous COMMAND contig)
endif()
