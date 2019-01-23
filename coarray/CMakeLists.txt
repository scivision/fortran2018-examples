cmake_minimum_required (VERSION 3.3)
project(coarraydemo Fortran)
enable_testing()
# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules/)
endif()

find_package(Coarray)

if(NOT Coarray_FOUND)
  return()
endif()

include(CheckFortranSourceCompiles)
set(CMAKE_REQUIRED_FLAGS ${Coarray_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_LIBRARIES ${Coarray_LIBRARY})
check_fortran_source_compiles("real :: x[*]; call co_sum(x); end" 
f18coarray SRC_EXT f90)
                              

add_executable(coarray_hello helloworld.f90)
target_compile_options(coarray_hello PRIVATE ${FFLAGS} ${Coarray_COMPILE_OPTIONS})
target_link_libraries(coarray_hello PRIVATE ${FLIBS} ${Coarray_LIBRARIES})
add_test(NAME CoarrayHello 
         COMMAND ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS} ./coarray_hello)


if(f18coarray)
  add_executable(coarray_pi pi.f90)
else()
# Intel 2018 does not yet support Fortran 2018 co_sum
  add_executable(coarray_pi pi2008.f90)
endif()
target_compile_options(coarray_pi PRIVATE ${FFLAGS} ${Coarray_COMPILE_OPTIONS})
target_link_libraries(coarray_pi PRIVATE ${FLIBS} ${Coarray_LIBRARIES})
add_test(NAME CoarrayPi 
         COMMAND ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS} ./coarray_pi)

