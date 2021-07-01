if(NOT f08block)
  message(STATUS "SKIP: F2008 block not supported by ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
  return()
endif()

set_directory_properties(PROPERTIES LABELS block)

add_executable(block block.f90)
add_test(NAME block:Block COMMAND $<TARGET_FILE:block>)
