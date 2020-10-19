module canonical
!! This is for Windows systems
!! see realpath_posix.f90 for POSIX
!!
!! path MUST EXIST for MacOS realpath()
!! path need not exist for Windows and Linux.
!!
!! https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/realpath.3.html
!!
!! https://linux.die.net/man/3/realpath
!!
!! https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/fullpath-wfullpath?view=vs-2019


use, intrinsic :: iso_c_binding, only: c_long, c_char, c_null_char
implicit none (type, external)
public :: realpath

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

function realpath(path)

character(:), allocatable :: realpath
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

realpath = trim(buf(:i-1))

end function realpath

end module canonical


program demo

use canonical, only : realpath

implicit none (type, external)

character(:), allocatable :: canon

! -- test directory
canon = realpath('..')

if (len_trim(canon) < 20) error stop 'ERROR: directory ' // canon // ' was not canonicalized '

! -- test file
canon = realpath('../foo.txt')

if (len_trim(canon) < 28) error stop 'ERROR: file ' // canon // ' was not canonicalized '

print *, canon

end program
