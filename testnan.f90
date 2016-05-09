program test_nan

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
! https://www.doc.ic.ac.uk/~eedwards/compsys/float/nan.html
nan_bit = transfer(Z'7FC00000',1.) 

! --------- print results

print *,'IEEE sp',nan_ieee_sp, 'isnan: ',isnan(nan_ieee_sp)
print *,'IEEE dp',nan_ieee_dp, 'isnan: ',isnan(nan_ieee_dp)
print *,'IEEE zp',nan_ieee_zp, 'isnan: ',isnan(real(nan_ieee_zp))
!ieee_is_nan work on real part only as well. think of the bit pattern definition.
print *,'NaN hexadecimal representations:'
print '(Z32)',nan_ieee_sp,nan_ieee_dp,nan_ieee_zp

! for single prec.:
! gfortran 6.0: FFC00000
! ifort 14.0: 7FC00000

print *,'bit_pattern',nan_bit, 'isnan: ',isnan(nan_bit)
print '(Z32)',nan_bit

end program test_nan
