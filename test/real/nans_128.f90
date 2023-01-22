program nans

use, intrinsic :: iso_fortran_env, only : real128, real64, real32
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan, ieee_is_nan

implicit none

character(*), parameter :: fmt='(A8,I3,2X,F5.1,6X,L1,2X,Z32)'

real(real128) :: nan_real128

complex(real32) :: nan_complex64
complex(real64) :: nan_complex128
complex(real128) :: nan_complex256

nan_real128 = ieee_value(0.,ieee_quiet_nan)
nan_complex64 = ieee_value(0., ieee_quiet_nan)
nan_complex128 = ieee_value(0.,ieee_quiet_nan)
nan_complex256 = ieee_value(0.,ieee_quiet_nan)

print '(A10,A8,A8,A28)','IEEE', 'value', 'isnan', 'hex'
print fmt,'real',storage_size(nan_real128),nan_real128, ieee_is_nan(nan_real128), nan_real128

print fmt,'complex',storage_size(nan_complex64),real(nan_complex64),ieee_is_nan(real(nan_complex64)),nan_complex64
print fmt,'complex',storage_size(nan_complex128),real(nan_complex128),ieee_is_nan(real(nan_complex128)),nan_complex128
print fmt,'complex',storage_size(nan_complex256),real(nan_complex256),ieee_is_nan(real(nan_complex256)),nan_complex256

end program
