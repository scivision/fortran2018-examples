Program polymorphism
! Polymorphic-like real kind at compile time by using single-line include in a kind module "use"d throughout program
!
! Output:
! cmake -Drealkind=real32      2pi   6.28318548  
! cmake -Drealkind=real64      2pi   6.2831853071795862  
! cmake -Drealkind=real128     2pi   6.28318530717958647692528676655900559  

use, intrinsic:: iso_fortran_env
implicit none
include 'kind.txt' ! output by CMake

real(wp), parameter :: pi = 4._wp * atan(1._wp)

print *,'2pi',timestwo(pi)

contains

elemental real(wp) function timestwo(a) result(a2)

real(wp), intent(in) :: a

a2 = 2*a

end function timestwo

end program
