find_package(OpenACC)

set(CMAKE_REQUIRED_FLAGS ${OpenACC_Fortran_FLAGS} ${OpenACC_Fortran_OPTIONS})
set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_LIBRARIES)

if(OpenACC_Fortran_FOUND)

check_fortran_source_compiles(
"
program simple
implicit none
integer :: i, x(2)

!$acc parallel loop
do i = 1, 2
  x(i) = i
enddo

end program
"
HAS_OpenACC
SRC_EXT f90
)

endif()

if(NOT HAS_OpenACC)
  message(STATUS "SKIP: OpenACC")
  return()
endif()

add_executable(simple_openacc simple_openacc.f90)
target_link_libraries(simple_openacc PRIVATE OpenACC::OpenACC_Fortran)

add_test(NAME OpenACCsimple COMMAND simple_openacc)
