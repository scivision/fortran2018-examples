program test_nan
! Note that -Ofast and -ffast-math break this program--
! NaN are not IEEE compiliant if using -Ofast or -ffast-math.
!
! Gfortran >= 6 needed for ieee_arithmetic: ieee_is_nan

use, intrinsic :: iso_c_binding, only: sp=>C_FLOAT, dp=>C_DOUBLE, qp=>C_LONG_DOUBLE, &
       zp=>C_DOUBLE_COMPLEX, zqp=>C_LONG_DOUBLE_COMPLEX
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan, ieee_is_nan
implicit none

real(sp) nan_sp,nan_bit
real(dp) nan_dp
real(qp) nan_qp
complex(zp) nan_zp
complex(zqp) nan_zqp

! this is the cross platform way to get NaN on modern compilers including gfortran and ifort.
nan_sp = ieee_value(1.,ieee_quiet_nan)
nan_dp = ieee_value(1.,ieee_quiet_nan)
nan_qp = ieee_value(1.,ieee_quiet_nan)
nan_zp = ieee_value(1.,ieee_quiet_nan)
nan_zqp = ieee_value(1.,ieee_quiet_nan)

! this is a bit-pattern way to get NaN by IEEE754 definition
nan_bit = transfer(Z'7FC00000',1.) 
! this is equivalent to transfer() by Fortran 2003
!nan_bit = real(z'7fc00000')  ! however, you will get Error: Result of FLOAT is NaN so use transfer() for the case where you're deliberately setting NaN


! --------- print results

print *,'IEEE  value  isnan  hex'
print '(A4,2X,F5.1,6X,L1,2X,Z32)','sp',nan_sp, ieee_is_nan(nan_sp), nan_sp
print '(A4,2X,F5.1,6X,L1,2X,Z32)','dp',nan_dp, ieee_is_nan(nan_dp), nan_dp
print '(A4,2X,F5.1,6X,L1,2X,Z32)','qp',nan_qp, ieee_is_nan(nan_qp), nan_qp

print '(A4,2X,F5.1,6X,L1,2X,Z32)','zp',real(nan_zp),ieee_is_nan(real(nan_zp)),nan_zp
print '(A4,2X,F5.1,6X,L1,2X,Z32)','zp',real(nan_zqp),ieee_is_nan(real(nan_zqp)),nan_zqp

print '(A4,2X,F5.1,6X,L1,2X,Z32)','bit',nan_bit,ieee_is_nan(nan_bit),nan_bit
!ieee_is_nan works on real part only, by the bit pattern definition.


! for single prec.:
! gfortran 8.0: FFC00000
! ifort 18.0: 7FC00000


end program test_nan
