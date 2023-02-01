set_property(DIRECTORY PROPERTY LABELS standard)

set(names big_integer bit_pattern block contiguous do_cycle
minloc_maxloc_mask minval_maxval_mask statement_function
)
if(f03ieee)
  list(APPEND names nan_max_min)
endif()
if(f18random)
  list(APPEND names random_init)
endif()

foreach(t IN LISTS names)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

if(f18abstract)
  add_executable(abstract_interface abstract.f90)
endif()

add_executable(shortcircuit ${PROJECT_SOURCE_DIR}/app/standard/short_circuit.f90)
# shaky result, don't CI test

add_executable(errstop_dynamic ${PROJECT_SOURCE_DIR}/app/standard/errorstop_variable.f90)
add_executable(justwait ${PROJECT_SOURCE_DIR}/app/standard/pause.f90)
# NO test

set_property(TARGET contiguous PROPERTY EXCLUDE_FROM_ALL $<NOT:$<BOOL:${f08contig}>>)
set_property(TEST contiguous PROPERTY DISABLED $<NOT:$<BOOL:${f08contig}>>)

if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  if(WIN32)
    target_compile_options(minloc_maxloc_mask PRIVATE /assume:noold_maxminloc)
  else()
    target_compile_options(minloc_maxloc_mask PRIVATE -assume noold_maxminloc)
  endif()
endif()
