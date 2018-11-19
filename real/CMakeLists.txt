cmake_minimum_required (VERSION 3.3)
project(fortran2018real Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

add_executable(nan nans.f90)
target_compile_options(nan PRIVATE ${FFLAGS})
add_test(NAME FortranNaN COMMAND nan)

if(f2008)

  add_library(assert ../assert.f90)
  add_executable(testassert not-finite.f90 fib3.f90)
  target_link_libraries(testassert assert)
  target_compile_options(testassert PRIVATE ${FFLAGS})
  add_test(NAME FortranAssert COMMAND testassert)


  add_executable(divprec div_precision.f90)
  target_compile_options(divprec PRIVATE ${FFLAGS})
  add_test(NAME FortranDivisionPrecision COMMAND divprec)

  add_executable(floatprec floating_precision.f90)
  target_compile_options(floatprec PRIVATE ${FFLAGS})
  add_test(NAME FortranFloatPrecision COMMAND floatprec)

  add_executable(hugeprec huge_precision.f90)
  target_compile_options(hugeprec PRIVATE ${FFLAGS})
  add_test(NAME FortranHugePrecision COMMAND hugeprec)

  add_executable(precprob precision_problems.f90)
  target_compile_options(precprob PRIVATE ${FFLAGS})
  add_test(NAME FortranPrecision COMMAND precprob)

endif()
