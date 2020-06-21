
if(NOT f08contig)
  message(STATUS "SKIP: contiguous arrays")
  return()
endif()

add_executable(contig contiguous.f90)
add_test(NAME contiguous COMMAND contig)
