cmake_minimum_required(VERSION 3.15)
project(F18coarray Fortran)
enable_testing()
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux: apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
  find_package(MPI COMPONENTS Fortran)
endif()

find_package(Coarray)

if(NOT Coarray_FOUND)
  message(STATUS "SKIP: Coarray")
  return()
endif()

# # "sync all" call is necessary to actually verify dynamically linked MPI stack works.
# include(CheckFortranSourceRuns)
# set(CMAKE_REQUIRED_FLAGS ${Coarray_COMPILE_OPTIONS})
# set(CMAKE_REQUIRED_INCLUDES ${Coarray_INCLUDE_DIRS})
# set(CMAKE_REQUIRED_LIBRARIES ${Coarray_LIBRARIES})
# check_fortran_source_runs("sync all; end"
#   f08coarray SRC_EXT f90)
# if(NOT f08coarray)
#   message(STATUS "SKIP: Coarray")
#   return()
# endif()
# check_fortran_source_runs("real :: x[*]; call co_sum(x); sync all; end"
#   f18coarray SRC_EXT f90)

add_executable(coarray_hello helloworld.f90)
target_link_libraries(coarray_hello PRIVATE Coarray::Coarray)
add_test(NAME CoarrayHello
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} $<TARGET_FILE:coarray_hello>)
set_tests_properties(CoarrayHello PROPERTIES RUN_SERIAL TRUE)


add_executable(coarray_pi pi.f90)
target_link_libraries(coarray_pi PRIVATE Coarray::Coarray)
add_test(NAME CoarrayPi
        COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} $<TARGET_FILE:coarray_pi>)
set_tests_properties(CoarrayPi PROPERTIES RUN_SERIAL TRUE)
