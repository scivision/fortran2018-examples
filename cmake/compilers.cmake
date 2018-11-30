if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

include(CheckFortranSourceCompiles)

check_fortran_source_compiles("
program a
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan
end" 
  f03ieee SRC_EXT f90)

check_fortran_source_compiles("
program a
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan
print *,ieee_is_nan(0._real128)
end" 
  f08kind SRC_EXT f90)

check_fortran_source_compiles("program a; error stop; end" 
  f08errorstop SRC_EXT f90)
  
check_fortran_source_compiles("program a; call execute_command_line(''); end" 
  f08command SRC_EXT f90)
                              
check_fortran_source_compiles("program a; call random_init(); end" 
  f18random SRC_EXT f90)

check_fortran_source_compiles("
module b
interface
module subroutine d
end subroutine d
end interface
end

submodule (b) c
contains
module procedure d
end
end

program a
end"
  f08submod SRC_EXT f90)

# ifort-19 yes, Flang yes, PGI yes, NAG yes, gfortran-8 no
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program c; print*,is_contiguous([0,0]); end" 
  f08contig SRC_EXT f90)
                              
if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(FFLAGS -traceback -warn)
  
  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    list(APPEND FFLAGS -debug extended -check all)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
    set(FFLAGS -std=f2018)
  endif()
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -fimplicit-none)
  
  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    list(APPEND FFLAGS -fcheck=all)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  set(FFLAGS -C)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)
  set(FLIBS -static-flang-libs)
  set(CFLAGS -W)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)

endif()

