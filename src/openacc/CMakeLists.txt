find_package(OpenACC)

if(NOT OpenACC_Fortran_FOUND)
  message(STATUS "SKIP: OpenACC")
  return()
endif()

add_executable(simple_openacc simple_openacc.f90)
target_link_libraries(simple_openacc PRIVATE OpenACC::OpenACC_Fortran)

add_test(NAME OpenACCsimple COMMAND simple_openacc)
