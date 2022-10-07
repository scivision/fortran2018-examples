check_source_compiles(Fortran
"program test
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan

print *, huge(0._real128)
print *, ieee_is_nan(0._real128)

end program"
f08kind)
