cmake_minimum_required(VERSION 3.14)
project(F18coarray Fortran)
enable_testing()
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux: apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
endif()

find_package(Coarray)

if(NOT Coarray_FOUND)
  message(STATUS "SKIP: Coarray tests")
  return()
endif()

# "sync all" call is necessary to actually verify dynamically linked MPI stack works.
include(CheckFortranSourceRuns)
set(CMAKE_REQUIRED_FLAGS ${Coarray_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_LIBRARIES ${Coarray_LIBRARY})
check_fortran_source_runs("sync all; end"
  f08coarray SRC_EXT f90)
if(NOT f08coarray)
  return()
endif()
check_fortran_source_runs("real :: x[*]; call co_sum(x); sync all; end"
  f18coarray SRC_EXT f90)


add_executable(coarray_hello helloworld.f90)
target_compile_options(coarray_hello PRIVATE ${FFLAGS} ${Coarray_COMPILE_OPTIONS})
target_link_libraries(coarray_hello PRIVATE ${FLIBS} ${Coarray_LIBRARIES})
add_test(NAME CoarrayHello
         COMMAND ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS} $<TARGET_FILE:coarray_hello>)
set_tests_properties(CoarrayHello PROPERTIES TIMEOUT 20 RUN_SERIAL TRUE)

if(f18coarray)
  add_executable(coarray_pi pi.f90)
else()
# Intel >= 20 supports Fortran 2018 co_sum
  add_executable(coarray_pi pi2008.f90)
endif()
target_compile_options(coarray_pi PRIVATE ${FFLAGS} ${Coarray_COMPILE_OPTIONS})
target_link_libraries(coarray_pi PRIVATE ${FLIBS} ${Coarray_LIBRARIES})
add_test(NAME CoarrayPi
         COMMAND ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS} $<TARGET_FILE:coarray_pi>)
set_tests_properties(CoarrayPi PROPERTIES TIMEOUT 20 RUN_SERIAL TRUE)
