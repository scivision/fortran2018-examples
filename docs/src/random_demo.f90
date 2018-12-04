program randominit

use random, only: random_init

real :: r
integer :: i

call random_init()

print *, 'these two random number should not match if random_init is working'

do i = 1, 2
  call random_number(r)
  print *,r
enddo

end program
