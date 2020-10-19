module canonical
!! This is for POSIX systems
!! see fullpath_windows.f90 for Windows
!!
!! path MUST EXIST for MacOS realpath()
!! path need not exist for Windows and Linux.
!!
!! https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/realpath.3.html
!!
!! https://linux.die.net/man/3/realpath
!!
!! https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/fullpath-wfullpath?view=vs-2019

use, intrinsic :: iso_c_binding, only: c_char, c_null_char
implicit none (type, external)
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

use canonical, only : realpath

implicit none

character(:), allocatable :: canon
character(*), parameter :: relpath = '../io/realpath_posix.f90'
logical :: exists

! -- test directory
canon = realpath('..')

if (len_trim(canon) < 20) error stop 'ERROR: directory ' // canon // ' was not canonicalized.'

! -- test
inquire(file=relpath, exist=exists)
if(.not.exists) error stop 77

canon = realpath(relpath)

if (len_trim(canon) < 28) error stop 'ERROR: file ' // canon // ' was not canonicalized.'

print *, canon

end program
