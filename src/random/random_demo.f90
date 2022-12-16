program demo_rand

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit
implicit none

real :: r1, r2

call random_init(.false., .false.)
call random_number(r1)
call random_init(.false., .false.)
call random_number(r2)
if (r1==r2) then
  write(stderr,*) 'random_init fail: ', r1, ' == ', r2
  error stop 'these two random number should not match if random_init is working'
endif

print *, "OK: random_init: ", r1, " /= ", r2

end program
