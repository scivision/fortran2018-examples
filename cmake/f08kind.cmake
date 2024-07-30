set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test

use, intrinsic :: iso_fortran_env, only: real128
use, intrinsic :: ieee_arithmetic, only: ieee_is_nan

real(real128) :: pi128 = 4*atan(1.0_real128)

print *, huge(0._real128)
print '(L1)', ieee_is_nan(0._real128)

end program"
f08kind
)
