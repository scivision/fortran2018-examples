if(f08block)
  add_executable(block block.f90)
  add_test(NAME Block COMMAND block)
endif()