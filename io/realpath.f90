module canonical
!! This only works for Linux / GNU systems
!! it does *not* work for MinGW or other Windows compilers
!! it also does not work for MacOS

use, intrinsic :: iso_c_binding, only: c_int, c_char, c_null_char
implicit none
public :: realpath

interface
integer(c_int) function realpath_c(path, rpath) bind(c, name='realpath')
import c_char, c_int
character(kind=c_char), intent(in) :: path(*)
character(kind=c_char), intent(out) :: rpath(*)
end function realpath_c
end interface

contains

function realpath(path)

character(:), allocatable :: realpath
character(*), intent(in) :: path

integer, parameter :: N = 2048
character(kind=c_char):: c_buf(N)
character(N) :: buf
integer :: i

i = realpath_c(path // c_null_char, c_buf)

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

character(*), parameter :: rel = '..'
character(:), allocatable :: canon

canon = realpath(rel)

if (canon == rel) then
  write(stderr,*) rel // ' was not canonicalized ' // canon
  error stop
endif

end program
