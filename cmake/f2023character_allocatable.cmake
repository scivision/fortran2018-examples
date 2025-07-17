block()

if(DEFINED f2023character_allocatable)
  return()
endif()

file(READ "${CMAKE_CURRENT_SOURCE_DIR}/test/character/f2023character_allocatable.f90" _src)

check_source_runs(Fortran "${_src}" f2023character_allocatable)

endblock()
