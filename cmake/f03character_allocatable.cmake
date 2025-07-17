# show that we don't need to manually allocate character variables or arrays
# for some older compilers this was buggy.

# In Fortran 2023, intrinsic assignment for say get_command(scalar) was enabled
# but before Fortran 2023 such calls needed allocate().

block()

if(DEFINED f03character_allocatable)
  return()
endif()

file(READ "${CMAKE_CURRENT_SOURCE_DIR}/test/character/f03character_allocatable.f90" _src)

check_source_runs(Fortran "${_src}" f03character_allocatable)

endblock()
