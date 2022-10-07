program demo_rand

implicit none

real :: r1, r2

print *, 'these two random number should not match if random_init is working'

call random_init(.false., .false.)
call random_number(r1)
call random_init(.false., .false.)
call random_number(r2)
if (r1==r2) error stop 'random_init fail'

end program
