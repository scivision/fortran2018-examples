program overwrite_stdout

!! overwrites terminal stdout in place e.g. for update status
!! char(13) is carriage return

use, intrinsic:: iso_fortran_env, only: stdout=>output_unit

implicit none (type, external)

integer :: i
integer, parameter :: N=5

do i = 1,N
  write(stdout,'(A1,F7.3,A1)',advance='no') achar(13),i/real(N)*100,'%'
  flush(stdout) !< necessary for ifort
end do

end program
