program overwrite_stdout
! overwrites terminal stdout in place e.g. for update status
! char(13) is carriage return
use, intrinsic:: iso_fortran_env, only: stdout=>output_unit
implicit none

integer :: i
integer, parameter :: N=12

do i = 1,N
  write(stdout,'(A1,F7.3,A1)',advance='no') char(13),i/real(N),'%'
  
  call sleep(1)

enddo

end program
