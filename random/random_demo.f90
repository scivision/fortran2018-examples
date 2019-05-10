use random, only: rand_init

real :: r
integer :: i

call rand_init(.false., .false.)

print *, 'these two random number should not match if random_init is working'

do i = 1, 2
  call random_number(r)
  print *,r
enddo

end program
