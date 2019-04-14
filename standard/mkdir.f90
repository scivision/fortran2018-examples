module std_mkdir

use, intrinsic:: iso_c_binding, only: c_int, c_char, C_NULL_CHAR
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

!> This interface connects to C stdlib functions present on any system.
interface
integer(c_int) function mkdir_c(path, mask) bind (C, name='mkdir')
  import c_int, c_char
  character(kind=c_char), intent(in) :: path(*)
  integer(c_int), value, intent(in) :: mask
end function mkdir_c
end interface

contains

function mkdir(path) result(ret)
!! Fortran standard compliant mkdir().
!! mkdir() is a GNU extension, not standard Fortran.
!! create a directory, with parents if needed
!! file separator is forward slash "/" only!
!!
!!
!! Tested on Linux and Windows
!! Michael Hirsch, Ph.D.

integer(c_int) :: ret
integer :: i,i0, ilast
character(len=*), intent(in) :: path
character(kind=c_char, len=:), allocatable :: buf
!! must use allocatable buffer, not direct substring to C
logical :: dir_exists

ret=0 !< in case directory already exists

buf = trim(path)

if (len(buf) == 0) then
  write(stderr,*) 'must specify directory to create'
  stop 1
endif

inquire(file=buf, exist=dir_exists)
if(dir_exists) then
  print *, buf//' already exists'
  return
endif

!> single relative directory
i = index(buf, '/')
if (i==0) then
  ret = mkdir_c(buf//C_NULL_CHAR, int(o'755', c_int))
  return
endif

!> handles parents
!> Note: auto-allocation also auto-reallocates--no deallocate() needed.
i=-1
i0=1
do while( i /= 0 )
  i = index(path(i0:), '/')

  if(i /= 0) then !< i0 skips last used separator
    i0 = i0 + i
    ilast = i0 - 1
  else  !< last path segment
    i0 = len_trim(path)
    ilast = i0
  endif

  !> allocated string buffer necessary for C interface
  buf = path(1:ilast)  !< don't include separator for Windows compatibility

  inquire(file=buf, exist=dir_exists)
  if(dir_exists) cycle

  ! print *,'i:',i,'i0:',i0,'ilast:',ilast,buf, len(buf)

  ret = mkdir_c(buf//C_NULL_CHAR, int(o'755', c_int))
  if (ret /= 0) then
    write(stderr,*) 'error creating '//buf
    return
  endif

enddo

end function mkdir

end module std_mkdir


program test_mkdir
!! just for testing
use std_mkdir, only: c_int, mkdir, stderr

implicit none

!> demo
character(4096) :: buf
integer(c_int) :: ret
logical :: dir_exists

call get_command_argument(1,buf)

ret = mkdir(trim(buf))

if(ret /= 0) stop ret

inquire(file=trim(buf), exist=dir_exists)

if(.not.dir_exists) then
  write(stderr,*) 'failed to create '//trim(buf)
  stop 1
endif

print *,trim(buf)//' exists.'

end program
