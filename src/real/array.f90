program array_real_precision
!! compact precision specification for arrays

use, intrinsic :: iso_fortran_env, only : real32, real64

implicit none

real(real64), parameter :: s64 = sum([real(real64) :: 0.1, 0.2])
real(real64), parameter :: s6432 = sum([real(real32) :: 0.1, 0.2])
real(real32), parameter :: s32 = sum([real(real32) :: 0.1, 0.2])

if (s64 == s32) error stop "sum(real64) should not equal sum(real32) in general"
print *, s6432 == s32  !< often true but maybe not always?

print '(a, f15.12)', "sum(real64): ",s64
print '(a, f15.12)', "sum(real32): ", s32
print '(a, f15.12)', "real64 sum(real32): ",s6432

end program
