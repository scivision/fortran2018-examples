program str2int
use, intrinsic:: iso_fortran_env, only: stdin=>input_unit
implicit none

integer :: M

read(stdin,*) M

print *, M

end program

