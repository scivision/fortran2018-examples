module canonical
!! This is for Windows systems
!! see realpath_posix.f90 for POSIX
!! path need not exist

use, intrinsic :: iso_c_binding, only: c_long, c_char, c_null_char
implicit none
public :: fullpath

interface
subroutine fullpath_c(absPath, relPath, maxLength) bind(c, name='_fullpath')
!! char *_fullpath(char *absPath, const char *relPath, size_t maxLength)
!! https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/fullpath-wfullpath?view=vs-2019
import c_char, c_long
character(kind=c_char), intent(in) :: relPath(*)
character(kind=c_char), intent(out) :: absPath(*)
integer(c_long), intent(in) :: maxLength
end subroutine fullpath_c
end interface

contains

function fullpath(path)

character(:), allocatable :: fullpath
character(*), intent(in) :: path

integer(c_long), parameter :: N = 260
character(kind=c_char):: c_buf(N)
character(N) :: buf
integer :: i

call fullpath_c(c_buf, path // c_null_char, N)

do i = 1,N
  if (c_buf(i) == c_null_char) exit
  buf(i:i) = c_buf(i)
enddo

fullpath = trim(buf(:i-1))

end function fullpath

end module canonical


program demo

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit
use canonical, only : fullpath

implicit none

character(:), allocatable :: canon

! -- test directory
canon = realpath('..')

if (len_trim(canon) < 20) then
  write(stderr,*) 'ERROR: ' // canon // ' was not canonicalized '
  error stop
endif

! -- test file
canon = realpath('../foo.txt')

if (len_trim(canon) < 28) then
  write(stderr,*) 'ERROR: ' // canon // ' was not canonicalized '
  error stop
endif

print *, canon

end program
