module std_mkdir
!! C binding to C-stdlib mkdir()
use, intrinsic:: iso_c_binding, only: c_int, c_char, C_NULL_CHAR
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

logical, parameter :: debug = .false.

!> This interface connects to C stdlib functions present on any system.
interface

#ifdef _WIN32
integer(c_int) function mkdir_win(path) bind (C, name='_mkdir')
!! https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/mkdir-wmkdir
import c_int, c_char
character(kind=c_char), intent(in) :: path(*)
end function mkdir_win
#else
integer(c_int) function mkdir_posix(path, mask) bind (C, name='mkdir')
!! https://linux.die.net/man/3/mkdir
import c_int, c_char
character(kind=c_char), intent(in) :: path(*)
integer(c_int), value, intent(in) :: mask
end function mkdir_posix
#endif
end interface

contains

integer(c_int) function mkdir(path) result(ret)
!! create a directory, with parents if needed
!! file separator is forward slash "/" only!

integer :: i,i0, ilast
character(len=*), intent(in) :: path
character(kind=c_char, len=:), allocatable :: buf
!! must use allocatable buffer, not direct substring to C

ret = 0
buf = trim(path)

if (len(buf) == 0) then
  error stop 'must specify directory to create'
endif

!> single relative directory  e.g.  mkdir('foo') or mkdir('foo/')
i = index(buf, '/')
if (i==0 .or. i==len(buf)) then
#ifdef _WIN32
  ret = mkdir_win(buf//C_NULL_CHAR)
#else
  ret = mkdir_posix(buf//C_NULL_CHAR, int(o'755', c_int))
#endif
  return
endif

!> handles parents
!> Note: auto-allocation also auto-reallocates--no deallocate() needed.
i=1
i0=1
do while( i > 0 )
  i = index(path(i0:), '/')

  if(i /= 0) then !< i0 skips last used separator
    i0 = i0 + i
    ilast = i0 - 1
  else  !< last path segment
    i0 = len_trim(path)
    if (i0 == ilast) exit  !< trailing slash
    ilast = i0
  endif

  !> allocated string buffer necessary for C interface
  buf = path(1:ilast)  !< don't include separator for Windows compatibility

  if(debug) print '(A,I4,A,I4,A,I4,A,I4)','i:',i,' i0:',i0,' ilast:',ilast,' '//buf, len(buf)

#ifdef _WIN32
  ret = mkdir_win(buf//C_NULL_CHAR)
#else
  ret = mkdir_posix(buf//C_NULL_CHAR, int(o'755', c_int))
#endif

  if(debug) print *,'mkdir() return code:',ret

enddo

end function mkdir

end module std_mkdir


program test_mkdir
!! just for testing
use std_mkdir
implicit none

!> demo
character(4096) :: buf
character(:), allocatable :: path, fpath
integer(c_int) :: ret
integer :: u
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
