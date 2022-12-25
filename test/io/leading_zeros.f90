program leading_zeros
!! Print leading zeros for real, integer in Fortran
use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, dp=>real64

implicit none

real(dp):: x
integer :: i

x = 1234.56_dp
i = 123456

write(stdout,'(a5,f12.7)') 'hello',x
write(stdout,'(i0.12)')  i

print *,'there should be leading zeros and no blanks for the real and integer above.'

end program
