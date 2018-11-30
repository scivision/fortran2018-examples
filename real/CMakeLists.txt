cmake_minimum_required (VERSION 3.3)
project(fortran2018real Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(NOT realbits)
  set(realbits 64)
endif()

add_executable(polymorph polymorphic.F90)
target_compile_options(polymorph PRIVATE ${FFLAGS})
target_link_libraries(polymorph ${FLIBS})
target_compile_definitions(polymorph PRIVATE REALBITS=${realbits})
add_test(NAME FortranPolymorphic COMMAND polymorph)


add_executable(divprec div_precision.F90)
target_link_libraries(divprec PRIVATE ${FLIBS})
target_compile_options(divprec PRIVATE ${FFLAGS})
target_compile_definitions(divprec PRIVATE REAL128=${f08kind})
add_test(NAME FortranDivisionPrecision COMMAND divprec)

add_executable(floatprec floating_precision.F90)
target_link_libraries(floatprec PRIVATE ${FLIBS})
target_compile_options(floatprec PRIVATE ${FFLAGS})
target_compile_definitions(floatprec PRIVATE REAL128=${f08kind})
add_test(NAME FortranFloatPrecision COMMAND floatprec)

add_executable(hugeprec huge_precision.F90)
target_link_libraries(hugeprec PRIVATE ${FLIBS})
target_compile_options(hugeprec PRIVATE ${FFLAGS})
target_compile_definitions(hugeprec PRIVATE REAL128=${f08kind})
add_test(NAME FortranHugePrecision COMMAND hugeprec)

add_executable(precprob precision_problems.F90)
target_link_libraries(precprob PRIVATE ${FLIBS})
target_compile_options(precprob PRIVATE ${FFLAGS})
target_compile_definitions(precprob PRIVATE REAL128=${f08kind})
add_test(NAME FortranPrecision COMMAND precprob)

if(f03ieee)
  add_executable(nan nans.F90)
  target_compile_options(nan PRIVATE ${FFLAGS})
  target_link_libraries(nan PRIVATE ${FLIBS})
  target_compile_definitions(nan PRIVATE REAL128=${f08kind} IEEENAN=${fieeenan})
  add_test(NAME FortranNaN COMMAND nan)
endif()

if(NOT f08errorstop OR NOT f03ieee)
  return()
endif()

add_library(assert assert.F90)
target_compile_options(assert PRIVATE ${FFLAGS})
target_link_libraries(assert PRIVATE ${FLIBS})
target_compile_definitions(assert PRIVATE REALBITS=${realbits})

add_executable(testassert not-finite.f90 fib3.F90)
target_link_libraries(testassert assert ${FLIBS})
target_compile_options(testassert PRIVATE ${FFLAGS})
add_test(NAME FortranAssert COMMAND testassert)

