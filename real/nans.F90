program nans
! Note that -Ofast and -ffast-math break this program--
! NaN are not IEEE compiliant if using -Ofast or -ffast-math.
!
! Gfortran >= 6 needed for ieee_arithmetic: ieee_is_nan

!use, intrinsic :: iso_c_binding, only: sp=>C_FLOAT, dp=>C_DOUBLE, qp=>C_LONG_DOUBLE
! more precision for real128,complex256 by using iso_fortran_env vs.  iso_c_binding
use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, qp=>real128
use, intrinsic :: iso_fortran_env, only: int32, int64
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan, ieee_is_nan
implicit none (type, external)

real(sp) :: nan_sp,nan_bit
real(dp) :: nan_dp
#ifdef REAL128
real(qp) :: nan_qp
complex(dp) :: nan_zp
complex(qp) :: nan_zqp
#endif

integer(int32) :: ISP
integer(int64) :: IDP


! this is the cross platform way to get NaN on modern compilers including gfortran and ifort.
nan_sp = ieee_value(1.,ieee_quiet_nan)
nan_dp = ieee_value(1.,ieee_quiet_nan)
#ifdef REAL128
nan_qp = ieee_value(1.,ieee_quiet_nan)
nan_zp = ieee_value(1.,ieee_quiet_nan)
nan_zqp = ieee_value(1.,ieee_quiet_nan)
#endif

! nan_bit = transfer(Z'7FC00000', 1.)
!! this was a bit-pattern way to get NaN by IEEE754 definition,
!! but strict compilers like GCC 10 do not allow transfer(nan)

! --------- print results

ISP = transfer(nan_sp, ISP)
IDP = transfer(nan_dp, IDP)

print *,'IEEE  value  isnan  hex'
print '(A4,2X,F5.1,6X,L1,2X,Z32)','sp',nan_sp, ieee_is_nan(nan_sp), ISP
print '(A4,2X,F5.1,6X,L1,2X,Z32)','dp',nan_dp, ieee_is_nan(nan_dp), IDP

#ifdef REAL128
print '(A4,2X,F5.1,6X,L1,2X,Z32)','qp',nan_qp, ieee_is_nan(nan_qp), nan_qp

print '(A4,2X,F5.1,6X,L1,2X,Z32)','zp',real(nan_zp),ieee_is_nan(real(nan_zp)),nan_zp
print '(A4,2X,F5.1,6X,L1,2X,Z32)','zqp',real(nan_zqp),ieee_is_nan(real(nan_zqp)),nan_zqp
#endif

! for single prec.:
! gfortran 8.0: FFC00000
! ifort 18.0: 7FC00000

end program
