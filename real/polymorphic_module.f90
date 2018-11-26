module funcs
use, intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64
implicit none  ! takes affect for all procedures within module

interface addtwo
  procedure addtwo_s, addtwo_d, addtwo_i
end interface addtwo

contains

elemental real(sp) function addtwo_s(x) result(y)
real(sp), intent(in) :: x

y = x + 2
end function addtwo_s


elemental real(dp) function addtwo_d(x) result(y)
real(dp), intent(in) :: x

y = x + 2
end function addtwo_d


elemental integer function addtwo_i(x) result(y)
integer, intent(in) :: x

y = x + 2
end function addtwo_i

end module funcs


program test2

use funcs
implicit none

real(sp) :: twos = 2._sp
real(dp) :: twod = 2._dp
integer :: twoi = 2
 

print *, addtwo(twos), addtwo(twod), addtwo(twoi)

end program
