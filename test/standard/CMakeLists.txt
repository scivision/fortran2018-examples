set_property(DIRECTORY PROPERTY LABELS standard)

set(names big_integer bit_pattern block
do_cycle
minloc_maxloc_mask minval_maxval_mask recursive statement_function
)
if(f03ieee)
  list(APPEND names nan_max_min)
endif()
if(f18random)
  list(APPEND names random_init)
endif()
if(f08contig)
  list(APPEND names contiguous_assumed_shape contiguous_pointer)
endif()

foreach(t IN LISTS names)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

if(f18abstract)
  add_executable(abstract_interface abstract.f90)
  add_executable(abstract_procedure abstract_procedure.f90)
endif()

add_executable(lubounds bounds.f90)
add_test(NAME LUbounds COMMAND lubounds)

add_executable(shortcircuit ${PROJECT_SOURCE_DIR}/app/standard/short_circuit.f90)
# shaky result, don't CI test

add_executable(errstop_dynamic ${PROJECT_SOURCE_DIR}/app/standard/errorstop_variable.f90)
add_executable(justwait ${PROJECT_SOURCE_DIR}/app/standard/pause.f90)
# NO test

if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  if(WIN32)
    target_compile_options(minloc_maxloc_mask PRIVATE /assume:noold_maxminloc)
  else()
    target_compile_options(minloc_maxloc_mask PRIVATE -assume noold_maxminloc)
  endif()
endif()
