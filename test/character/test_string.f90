program test_string

use, intrinsic:: iso_c_binding, only: c_null_char
use string_utils

implicit none

call test_split()
print *,'PASSED: split'
call test_lowercase()
print *,'PASSED: HDF5 character'
call test_strip_null()
print *,'PASSED: null strip'

contains

subroutine test_split()


character(*),parameter :: mystr="hello.txt"
character(:),allocatable :: stem

stem = split(mystr,'.')
print '(A)', stem

if (len(stem) /= 5) error stop 'allocatable character of unexpected length'


end subroutine test_split

subroutine test_lowercase()

character(*), parameter :: hello = 'HeLl0 Th3rE !>? '
  !! Fortran 2003 allocatable string

if (.not.(toLower(hello)=='hell0 th3re !>? ')) error stop 'error: lowercase conversion'

if (.not.(trim(toLower(hello))=='hell0 th3re !>?')) error stop 'Allocatable lowercase conversion error'

end subroutine test_lowercase


subroutine test_strip_null()
character(*), parameter :: hello = 'HeLl0 Th3rE !>? '

if (.not.strip_trailing_null(hello // c_null_char) == hello) error stop 'problem stripping trailing null'

end subroutine test_strip_null

end program
