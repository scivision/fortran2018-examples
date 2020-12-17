cmake_minimum_required(VERSION 3.15)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "default build type")
endif()
project(F18real LANGUAGES Fortran)
enable_testing()

# ctest -N => 8 tests
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08kind.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f18prop.cmake)

if(NOT realbits)
  set(realbits 64)
endif()

set(real_prec "integer,parameter :: wp=real${realbits}")

add_executable(cast_int2real cast_int2real.f90)
add_test(NAME real:cast_int2real COMMAND $<TARGET_FILE:cast_int2real>)

configure_file(polymorphic.in.f90 polymorphic.f90)
add_executable(polymorph ${CMAKE_CURRENT_BINARY_DIR}/polymorphic.f90)
add_test(NAME real:polymorphic COMMAND $<TARGET_FILE:polymorph>)

add_executable(coerce coerce.f90)
add_test(NAME real:coerce COMMAND $<TARGET_FILE:coerce>)

add_executable(epsilon epsilon.f90)
add_test(NAME real:epsilon COMMAND $<TARGET_FILE:epsilon>)

if(f08kind)
  add_executable(divprec div_precision.f90)
  add_test(NAME real:divisionPrecision COMMAND divprec)

  add_executable(floatprec floating_precision.f90)
  add_test(NAME real:floatPrecision COMMAND floatprec)

  add_executable(hugeprec huge_precision.f90)
  add_test(NAME real:hugePrecision COMMAND hugeprec)

  add_executable(precprob precision_problems.f90)
  add_test(NAME real:precisionProblems COMMAND precprob)
endif(f08kind)


if(f18prop)
  add_executable(properties properties.f90)
  add_test(NAME real:properties COMMAND properties)
endif()

add_library(assert OBJECT assert.f90)

if(f08kind)
  add_executable(nan nans.f90)
  add_test(NAME real:NaN COMMAND nan)

  add_executable(test_assert finite.f90)
  target_link_libraries(test_assert PRIVATE assert)
  add_test(NAME real:assert COMMAND $<TARGET_FILE:test_assert>)
endif(f08kind)
