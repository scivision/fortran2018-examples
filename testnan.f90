program test_nan
! Note that -Ofast and -ffast-math break this program--
! NaN are not IEEE compiliant if using -Ofast or -ffast-math.

use, intrinsic :: iso_c_binding, only: sp=>C_FLOAT, dp=>C_DOUBLE, zp=>C_DOUBLE_COMPLEX
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
implicit none

real(sp) nan_ieee_sp,nan_bit
real(dp) nan_ieee_dp
complex(zp) nan_ieee_zp

! this is the cross platform way to get NaN on modern compilers including gfortran and ifort.
nan_ieee_sp = ieee_value(1.,ieee_quiet_nan)
nan_ieee_dp = ieee_value(1.,ieee_quiet_nan)
nan_ieee_zp = ieee_value(1.,ieee_quiet_nan)

! this is a bit-pattern way to get NaN by IEEE754 definition
nan_bit = transfer(Z'7FC00000',1.) 
! this is equivalent to transfer() by Fortran 2003
!nan_bit = real(z'7fc00000')  ! however, you will get Error: Result of FLOAT is NaN so use transfer() for the case where you're deliberately setting NaN


! --------- print results

print *,'IEEE  value  isnan  hex'
print '(A4,2X,F5.1,6X,L1,2X,Z16)','sp',nan_ieee_sp,isnan(nan_ieee_sp),nan_ieee_sp
print '(A4,2X,F5.1,6X,L1,2X,Z16)','dp',nan_ieee_dp,isnan(nan_ieee_dp),nan_ieee_dp
print '(A4,2X,F5.1,6X,L1,2X,Z16)','zp',real(nan_ieee_zp),isnan(real(nan_ieee_zp)),nan_ieee_zp
print '(A4,2X,F5.1,6X,L1,2X,Z16)','bit',nan_bit,isnan(nan_bit),nan_bit
!ieee_is_nan works on real part only, by the bit pattern definition.


! for single prec.:
! gfortran 6.0: FFC00000
! ifort 14.0: 7FC00000


end program test_nan
