! checks if compiler can handle F2018 Error Stop with variable

program f2018errorstop

use, intrinsic :: iso_fortran_env
implicit none

real :: r
character(10) :: c

call random_number(r)
write(c,'(f10.3)') r

print *,compiler_version()

error stop 'dynamic error stop working: random_number: '//c

end program
