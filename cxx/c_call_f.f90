module mytest

use, intrinsic:: iso_c_binding, only: dp=>c_double, c_int

implicit none (type, external)

contains

pure subroutine timestwo(z,z2,N) bind(c)
! elemental is not allowed with BIND(C)

integer(c_int), intent(in) :: N
real(dp),intent(in) :: z(N)
real(dp),intent(out) :: z2(N)

z2 = 2*z

end subroutine timestwo

end module mytest
