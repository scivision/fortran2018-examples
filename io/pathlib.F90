module pathlib

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none
private
public :: mkdir, copyfile

contains

integer function copyfile(source, dest) result(istat)

character(*), intent(in) :: source, dest
character(len(source)) :: src
character(len(dest)) :: dst
logical :: exists
integer :: icstat

#if defined(_WIN32)
character(*), parameter :: CMD='copy '
src = filesep_swap(source)
dst = filesep_swap(dest)
#else
character(*), parameter ::  CMD='cp -r '
src = source
dst = dest
#endif

call execute_command_line(CMD//src//' '//dst, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat
if (istat /= 0) write(stderr,*) 'ERROR: '//CMD//src//' '//dst

end function copyfile


integer function mkdir(path) result(istat)
!! create a directory, with parents if needed

character(*), intent(in) :: path
character(len(path)) :: p
integer :: icstat

#if defined(_WIN32)
character(*), parameter :: CMD='mkdir '
p = filesep_swap(path)
#else
character(*), parameter ::  CMD='mkdir -p '
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

end module pathlib
