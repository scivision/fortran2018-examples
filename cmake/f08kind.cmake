check_fortran_source_compiles("
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan

if (huge(0._real128) /= 1.18973149535723176508575932662800702E+4932_real128) stop 1

end program"
  f08kind SRC_EXT f90)