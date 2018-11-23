if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program es; error stop; end" f2008
                              SRC_EXT f90)

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(FFLAGS -check all -traceback -warn -debug extended)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
    set(FFLAGS -std=f2018)
  endif()
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -fcheck=all -fimplicit-none)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  set(FFLAGS -C)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)
  set(FLIBS -static-flang-libs)
  set(CFLAGS -W)
endif()

