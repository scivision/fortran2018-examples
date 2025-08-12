program test_bounds
use iso_fortran_env, only : error_unit
implicit none

real, allocatable :: a(:)
integer :: L1,L2, U1,U2
allocate(a(1:2))

L1 = lbound(a,1)
U1 = ubound(a,1)

call c_bounder(a)

L2 = lbound(a,1)
U2 = ubound(a,1)

if (L1 /= L2 .or. U1 /= U2) then
  write(error_unit, '(a,2i2,a,2i2)') 'FAIL: bounds changed before/after lower:', L1,L2, " upper: ", U1,U2
  error stop
endif

print '(a)', "bounds check OK"

contains

subroutine c_bounder(a) bind(c)
real,  intent(inout) :: a(:)
end subroutine c_bounder

end program
