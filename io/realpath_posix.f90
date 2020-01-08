module canonical
!! This is for POSIX systems
!! see fullpath_windows.f90 for Windows
!! path need not exist

use, intrinsic :: iso_c_binding, only: c_char, c_null_char
implicit none
public :: realpath

interface
subroutine realpath_c(path, rpath) bind(c, name='realpath')
import c_char
character(kind=c_char), intent(in) :: path(*)
character(kind=c_char), intent(out) :: rpath(*)
end subroutine realpath_c
end interface

contains

function realpath(path)

character(:), allocatable :: realpath
character(*), intent(in) :: path

integer, parameter :: N = 2048
character(kind=c_char):: c_buf(N)
character(N) :: buf
integer :: i

call realpath_c(path // c_null_char, c_buf)

do i = 1,N
  if (c_buf(i) == c_null_char) exit
  buf(i:i) = c_buf(i)
enddo

realpath = trim(buf(:i-1))

end function realpath

end module canonical


program demo

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit
use canonical, only : realpath

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
