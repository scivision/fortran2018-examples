module abspath
!! Concept: use C++17 filesystem from Fortran
!! TODO: this is not yet fully working, just a concept
!! waiting for GCC 10, Clang 10, Intel 20. to see if practical yet.

use, intrinsic :: iso_c_binding, only: c_int, c_char, c_null_char
implicit none (type, external)
public :: realpath

interface
subroutine canonical_cxx(path) bind(c, name='canonical')
import c_char
character(kind=c_char), intent(inout) :: path(*)
end subroutine canonical_cxx
end interface

contains

function realpath(path)

character(:), allocatable :: realpath
character(*), intent(in) :: path

integer, parameter :: N = 2048
character(kind=c_char):: c_buf(N)
character(N) :: buf
integer :: i

c_buf = path // c_null_char

call canonical_cxx(c_buf)

do i = 1,N
  if (c_buf(i) == c_null_char) exit
  buf(i:i) = c_buf(i)
enddo

realpath = trim(buf(:i-1))

end function realpath

end module abspath


program demo

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit
use abspath, only : realpath

implicit none

character(*), parameter :: rel = '..'
character(:), allocatable :: canon

canon = realpath(rel)

if (canon == rel) then
  write(stderr,*) rel // ' was not canonicalized ' // canon
  error stop
endif

end program
