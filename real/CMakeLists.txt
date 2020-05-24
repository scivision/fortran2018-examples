cmake_minimum_required(VERSION 3.15)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "default build type")
endif()
project(F18real LANGUAGES Fortran)
enable_testing()

# ctest -N => 8 tests

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)

  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08kind.cmake)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f18prop.cmake)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f03ieee.cmake)
endif()

if(NOT realbits)
  set(realbits 64)
endif()

set(real_prec "integer,parameter :: wp=real${realbits}")

configure_file(polymorphic.in.f90 polymorphic.f90)
add_executable(polymorph ${CMAKE_CURRENT_BINARY_DIR}/polymorphic.f90)
add_test(NAME Polymorphic COMMAND polymorph)

if(f08kind)
  add_executable(divprec div_precision.F90)
  add_test(NAME DivisionPrecision COMMAND divprec)

  add_executable(floatprec floating_precision.F90)
  add_test(NAME FloatPrecision COMMAND floatprec)

  add_executable(hugeprec huge_precision.F90)
  add_test(NAME HugePrecision COMMAND hugeprec)

  add_executable(precprob precision_problems.f90)
  add_test(NAME PrecisionProblems COMMAND precprob)
endif(f08kind)


if(f18prop)
  add_executable(properties properties.f90)
  add_test(NAME Properties COMMAND properties)
endif()


if(f03ieee)

  add_library(assert OBJECT assert.f90)

  if(f08kind)
    add_executable(nan nans.f90)
    add_test(NAME NaN COMMAND nan)

    add_executable(test_assert finite.f90)
    target_link_libraries(test_assert PRIVATE assert)
    add_test(NAME Assert COMMAND $<TARGET_FILE:test_assert>)
  endif(f08kind)

endif(f03ieee)
