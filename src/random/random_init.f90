program rand_init_seed
!! by Michael Hirsch, enhanced by Steve Lionel to better match Fortran Standard specification.

use, intrinsic :: iso_fortran_env, only : compiler_version
implicit none

integer :: s
integer, allocatable :: seed1(:),seed2(:)

print *, compiler_version()

call random_seed(size=s)
allocate (seed1(s),seed2(s))

call random_init(.false., .false.)
call random_seed (get=seed1)
print *, "Seed 1:", seed1

call random_init(.false., .false.)
call random_seed(get=seed2)
print *, "Seed 2:", seed2

if (all(seed1==seed2)) error stop 'random_init fail: these two seeds should not match if random_init is working'

print *, "OK: random_init"

end program
