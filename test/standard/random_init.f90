program rand_init_seed
!! by Michael Hirsch, enhanced by Steve Lionel to better match Fortran Standard specification.

use, intrinsic :: iso_fortran_env, only : compiler_version, stderr=>error_unit
implicit none

integer :: s
integer, allocatable :: seed1(:),seed2(:)

print '(a)', compiler_version()

call random_seed(size=s)
print '(a,i0)', "random_seed size: ", s
allocate (seed1(s), seed2(s))

call random_init(.false., .false.)
call random_seed (get=seed1)
print *, "Seed 1: ", seed1

call random_init(.false., .false.)
call random_seed(get=seed2)
print *, "Seed 2: ", seed2

if (all(seed1==seed2)) then
  write(stderr, '(a)') 'ERROR: random_init(.false., .false.): two seeds above should not match if random_init is working'
else
  print *, "OK: random_init"
endif

end program
