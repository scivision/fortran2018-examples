program cast_int2real
!! show Fortran standard casting rules.
!! This helps avoid needless 1._real64 etc.

implicit none

call assert_equal(1 / 5., 0.2)
call assert_equal(1. / 5, 0.2)
call assert_equal(4*atan(1.), 3.14159265359)
call assert_equal(1 + 4., 5.)


contains

subroutine assert_equal(val, ref)
real, intent(in) :: val, ref
if (abs(val - ref) > 0.0001) error stop
end subroutine assert_equal

end program
