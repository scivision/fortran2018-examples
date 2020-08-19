if(f08block)
  add_executable(block block.f90)
  add_test(NAME block:Block COMMAND $<TARGET_FILE:block>)
endif()
