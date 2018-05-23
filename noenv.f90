program noenv

use, intrinsic:: iso_fortran_env, only: error_unit

implicit none

character(4) :: buf
integer :: h,ios

call get_environment_variable('LINES',buf,status=ios)

if (ios/=0) then
  write(error_unit,*) 'got error code',ios,'on trying to get LINES'
  stop
endif

read(buf,*) h


end program
