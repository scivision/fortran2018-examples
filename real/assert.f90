module assert

use, intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, stderr=>error_unit
use, intrinsic:: ieee_arithmetic

implicit none (type, external)
private
public :: isclose, assert_isclose

interface isclose
module procedure isclose_32, isclose_64
end interface isclose

interface assert_isclose
module procedure assert_isclose_32, assert_isclose_64
end interface assert_isclose

contains

elemental logical function isclose_32(actual, desired, rtol, atol, equal_nan) result (isclose)
! inputs
! ------
! actual: value "measured"
! desired: value "wanted"
! rtol: relative tolerance
! atol: absolute tolerance
! equal_nan: consider NaN to be equal?
!
!  rtol overrides atol when both are specified
!
! https://www.python.org/dev/peps/pep-0485/#proposed-implementation
! https://github.com/PythonCHB/close_pep/blob/master/is_close.py

real(sp), intent(in) :: actual, desired
real(sp), intent(in), optional :: rtol, atol
logical, intent(in), optional :: equal_nan

real(sp) :: r,a
logical :: n
! this is appropriate INSTEAD OF merge(), since non present values aren't defined.
r = 1e-5_sp
a = 0
n = .false.
if (present(rtol)) r = rtol
if (present(atol)) a = atol
if (present(equal_nan)) n = equal_nan

!print*,r,a,n,actual,desired

!--- sanity check
if ((r < 0).or.(a < 0)) error stop 'invalid tolerance parameter(s)'
!--- equal nan
isclose = n.and.(ieee_is_nan(actual).and.ieee_is_nan(desired))
if (isclose) return
!--- Inf /= Inf, unequal NaN
if (.not.ieee_is_finite(actual) .or. .not.ieee_is_finite(desired)) return
!--- floating point closeness check
isclose = abs(actual-desired) <= max(r * max(abs(actual), abs(desired)), a)

end function isclose_32


elemental logical function isclose_64(actual, desired, rtol, atol, equal_nan) result (isclose)
! inputs
! ------
! actual: value "measured"
! desired: value "wanted"
! rtol: relative tolerance
! atol: absolute tolerance
! equal_nan: consider NaN to be equal?
!
!  rtol overrides atol when both are specified
!
! https://www.python.org/dev/peps/pep-0485/#proposed-implementation
! https://github.com/PythonCHB/close_pep/blob/master/is_close.py

real(dp), intent(in) :: actual, desired
real(dp), intent(in), optional :: rtol, atol
logical, intent(in), optional :: equal_nan

real(dp) :: r,a
logical :: n
! this is appropriate INSTEAD OF merge(), since non present values aren't defined.
r = 1e-5_dp
a = 0
n = .false.
if (present(rtol)) r = rtol
if (present(atol)) a = atol
if (present(equal_nan)) n = equal_nan

!print*,r,a,n,actual,desired

!--- sanity check
if ((r < 0).or.(a < 0)) error stop 'invalid tolerance parameter(s)'
!--- equal nan
isclose = n.and.(ieee_is_nan(actual).and.ieee_is_nan(desired))
if (isclose) return
!--- Inf /= Inf, unequal NaN
if (.not.ieee_is_finite(actual) .or. .not.ieee_is_finite(desired)) return
!--- floating point closeness check
isclose = abs(actual-desired) <= max(r * max(abs(actual), abs(desired)), a)

end function isclose_64


impure elemental subroutine assert_isclose_64(actual, desired, rtol, atol, equal_nan, err_msg)
! inputs
! ------
! actual: value "measured"
! desired: value "wanted"
! rtol: relative tolerance
! atol: absolute tolerance
! equal_nan: consider NaN to be equal?
! err_msg: message to print on mismatch
!
! rtol overrides atol when both are specified

real(dp), intent(in) :: actual, desired
real(dp), intent(in), optional :: rtol, atol
logical, intent(in), optional :: equal_nan
character(*), intent(in), optional :: err_msg

if (.not.isclose(actual,desired,rtol,atol,equal_nan)) then
  if (present(err_msg)) write(stderr,'(A)', advance='no') err_msg
  write(stderr,*) ': actual',actual,'desired',desired
  error stop
endif

end subroutine assert_isclose_64


impure elemental subroutine assert_isclose_32(actual, desired, rtol, atol, equal_nan, err_msg)
! inputs
! ------
! actual: value "measured"
! desired: value "wanted"
! rtol: relative tolerance
! atol: absolute tolerance
! equal_nan: consider NaN to be equal?
! err_msg: message to print on mismatch
!
! rtol overrides atol when both are specified

real(sp), intent(in) :: actual, desired
real(sp), intent(in), optional :: rtol, atol
logical, intent(in), optional :: equal_nan
character(*), intent(in), optional :: err_msg

if (.not.isclose(actual,desired,rtol,atol,equal_nan)) then
  if (present(err_msg)) write(stderr,'(A)', advance='no') err_msg
  write(stderr,*) ': actual',actual,'desired',desired
  error stop
endif

end subroutine assert_isclose_32

end module assert
