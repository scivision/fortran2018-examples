program big_integer
!! this gets to 20! with int64 or 12! with int32
use, intrinsic :: iso_fortran_env, only : int64, real128

implicit none

integer(int64) :: n, i, fac
integer :: ios
character(2) :: argv

n = 10
call get_command_argument(1, argv, status=ios)
if (ios==0) read(argv,'(i2)') n

if (n<0) error stop 'N >= 0 for factorial(N)'

fac = 1
do i = 1, n
  fac = fac * i
end do

! fac = gamma(real(n, real128))

print *, 'factorial',n,'=',fac

end program
