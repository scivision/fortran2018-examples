set_property(DIRECTORY PROPERTY LABELS standard)

if(f18abstract)
  add_executable(abstract_interface abstract.f90)
endif()

add_executable(shortcircuit ${PROJECT_SOURCE_DIR}/app/standard/short_circuit.f90)
# shaky result, don't CI test

add_executable(bitpat bitpat.f90)
add_test(NAME bit_pattern COMMAND bitpat)

add_executable(do_cycle do_cycle.f90)
add_test(NAME doCycle COMMAND do_cycle)

add_executable(big_integer big_integer.f90)
add_test(NAME big_integer COMMAND big_integer)

add_executable(errstop_dynamic ${PROJECT_SOURCE_DIR}/app/standard/errorstop_variable.f90)
add_executable(justwait ${PROJECT_SOURCE_DIR}/app/standard/pause.f90)
# NO test

# --- Fortran 77 statement functions (obsolete)
add_executable(statement statement_function.f90)
add_test(NAME statement_function COMMAND statement)

# --- possibly suprising behaviors
if(f03ieee)
  add_executable(nan_max_min maxmin_nan.f90)
  add_test(NAME NaNminmax COMMAND nan_max_min)
endif()

add_executable(minloc_maxloc_mask minloc_maxloc_mask.f90)
if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  if(WIN32)
    target_compile_options(minloc_maxloc_mask PRIVATE /assume:noold_maxminloc)
  else()
    target_compile_options(minloc_maxloc_mask PRIVATE -assume noold_maxminloc)
  endif()
endif()
add_test(NAME MinlocMaxlocMask COMMAND minloc_maxloc_mask)

add_executable(minval_maxval_mask minval_maxval_mask.f90)
add_test(NAME MinvalMaxvalMask COMMAND minval_maxval_mask)
