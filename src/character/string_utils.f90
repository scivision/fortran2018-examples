module string_utils
!! This module is for string manipulation

use, intrinsic:: iso_c_binding, only: c_null_char

implicit none (type, external)

contains

pure function toLower(str)
character(*), intent(in) :: str
character(len(str)) :: toLower
!! convert uppercase characters to lowercase
!!
!! can be trivially extended to non-ASCII
!! Not elemental to support strict Fortran 2018 compliance

character(*), parameter :: lower="abcdefghijklmnopqrstuvwxyz", &
                           upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
integer :: i,j

toLower = str

do i = 1,len(str)
  j = index(upper,str(i:i))
  if (j > 0) toLower(i:i) = lower(j:j)
end do

end function toLower


pure function strip_trailing_null(str) result(stripped)
character(*), intent(in) :: str
character(:), allocatable :: stripped
!! strip trailing C null from strings
integer :: i

i = len_trim(str)
if (str(i:i) == c_null_char) then
  stripped = trim(str(:i-1))
else
  stripped = trim(str)
endif

end function strip_trailing_null


pure function truncate_string_null(str) result(trunc)
character(*), intent(in) :: str
character(:), allocatable :: trunc
!! truncate string to C_null_char
integer :: i

i = index(str, c_null_char)
if (i > 0) then
  trunc = trim(str(:i-1))
else !< didn't find any c_null
  trunc = trim(str)
endif

end function truncate_string_null

end module string_utils
