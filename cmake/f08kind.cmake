check_source_compiles(Fortran
"program test
use, intrinsic:: iso_fortran_env, only: real128

print *, huge(0._real128)

end program"
f08kind)
