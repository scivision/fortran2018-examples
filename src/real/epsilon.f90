program epstest

use, intrinsic :: iso_fortran_env, only : real32, real64
use, intrinsic :: ieee_arithmetic, only : ieee_next_after

implicit none (type, external)

real(real32) :: one32_eps, eps32
real(real64) :: one64_eps, eps64

eps32 = epsilon(0._real32)
eps64 = epsilon(0._real64)

print *, "epsilon real32", eps32
print *, "epsilon real64", eps64

one32_eps = ieee_next_after(1._real32, 2.)
one64_eps = ieee_next_after(1._real64, 2.)

print *, "ieee_next_after(1, 2) eps real32", one32_eps - 1
print *, "ieee_next_after(1, 2) eps real64", one64_eps - 1

!> this test should be bit exact true
if (one32_eps - eps32 /= 1) error stop "real32 epsilon not meeting specification"
if (one64_eps - eps64 /= 1) error stop "real64 epsilon not meeting specification"

end program
