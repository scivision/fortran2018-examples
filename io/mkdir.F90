module std_mkdir
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none
private
public :: mkdir

contains

integer function mkdir(path) result(istat)
!! create a directory, with parents if needed

character(*), intent(in) :: path
character(len(path)) :: p
integer :: icstat

#if defined(_WIN32) || defined(_WIN64)
character(6), parameter :: CMD='mkdir '
p = filesep_swap(path)
#else
character(9), parameter ::  CMD='mkdir -p '
p = path
#endif

call execute_command_line(CMD // p, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat
if (istat /= 0) write(stderr,*) 'ERROR: '//CMD//p

end function mkdir


function filesep_swap(path) result(swapped)
! swaps '/' to '\' for Windows systems

character(*), intent(in) :: path
character(len(path)) :: swapped
integer :: i

swapped = path
do
  i = index(swapped, '/')
  if (i == 0) exit
  swapped(i:i) = char(92)
end do

end function filesep_swap

end module std_mkdir


program test_mkdir
!! just for testing
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
use std_mkdir
implicit none

!> demo
character(4096) :: buf
character(:), allocatable :: path, fpath
integer :: ret, u
logical :: exists

call get_command_argument(1,buf)
path = trim(buf)
fpath = path // '/foo.txt'

ret = mkdir(path)

! check existance of path by writing file and checking file's existance
open(newunit=u, file=fpath, action='write', status='replace')
write(u,'(A)') 'bar'
close(u)

inquire(file=fpath, exist=exists)
if(.not.exists) then
  write(stderr,*) fpath // ' failed to be created'
  error stop
endif
end program
