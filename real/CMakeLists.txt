cmake_minimum_required (VERSION 3.3)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(fortran2018real Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

if(NOT realbits)
  set(realbits 64)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f03ieee.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08kind.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f18prop.cmake)

add_executable(polymorph polymorphic.F90)
target_compile_options(polymorph PRIVATE ${FFLAGS})
target_link_libraries(polymorph ${FLIBS})
target_compile_definitions(polymorph PRIVATE REALBITS=${realbits})
add_test(NAME Polymorphic COMMAND polymorph)


add_executable(divprec div_precision.F90)
target_link_libraries(divprec PRIVATE ${FLIBS})
target_compile_options(divprec PRIVATE ${FFLAGS})
if(f08kind)
target_compile_definitions(divprec PRIVATE REAL128)
endif()
add_test(NAME DivisionPrecision COMMAND divprec)

add_executable(floatprec floating_precision.F90)
target_link_libraries(floatprec PRIVATE ${FLIBS})
target_compile_options(floatprec PRIVATE ${FFLAGS})
if(f08kind)
target_compile_definitions(floatprec PRIVATE REAL128)
endif()
add_test(NAME FloatPrecision COMMAND floatprec)

add_executable(hugeprec huge_precision.F90)
target_link_libraries(hugeprec PRIVATE ${FLIBS})
target_compile_options(hugeprec PRIVATE ${FFLAGS})
if(f08kind)
target_compile_definitions(hugeprec PRIVATE REAL128)
endif()
add_test(NAME HugePrecision COMMAND hugeprec)

if(f08kind)
add_executable(precprob precision_problems.f90)
target_link_libraries(precprob PRIVATE ${FLIBS})
target_compile_options(precprob PRIVATE ${FFLAGS})
add_test(NAME PrecisionProblems COMMAND precprob)
endif()


if(f18prop)
add_executable(properties properties.f90)
target_compile_options(properties PRIVATE ${FFLAGS})
add_test(NAME Fortran2018Properties COMMAND properties)
endif()


if(f03ieee)

add_executable(nan nans.F90)
target_compile_options(nan PRIVATE ${FFLAGS})
target_link_libraries(nan PRIVATE ${FLIBS})
if(f08kind)
target_compile_definitions(nan PRIVATE REAL128 IEEENAN)
endif()
add_test(NAME NaN COMMAND nan)

add_library(assert assert.F90)
target_compile_options(assert PRIVATE ${FFLAGS})
target_link_libraries(assert PRIVATE ${FLIBS})
target_compile_definitions(assert PRIVATE REALBITS=${realbits})

if(f08kind)
add_executable(testassert not-finite.f90 fib3.f90)
target_link_libraries(testassert assert ${FLIBS})
target_compile_options(testassert PRIVATE ${FFLAGS})
add_test(NAME Assert COMMAND testassert)
endif()

endif()
