program nans
! Compiler options like -Ofast and -ffast-math break this program.
! NaN are not IEEE compliant if using such options.
!
! Gfortran >= 6 needed for ieee_arithmetic: ieee_is_nan

!> Examples

!> Gfortran 10.2.0 Windows
!       IEEE   value   isnan                         hex
!     real 32    NaN      T                          FFC00000
!     real 64    NaN      T                  FFF8000000000000
!     real128    NaN      T  FFFF8000000000000000000000000000
!  complex 64    NaN      T                          FFC00000
!  complex128    NaN      T                  FFF8000000000000
!  complex256    NaN      T  FFFF8000000000000000000000000000

!> Ifort 2021.1 Winodws and Ifx 2021.1 Windows
!       IEEE   value   isnan                         hex
!     real 32    NaN      T                          7FC00000
!     real 64    NaN      T                  7FF8000000000000
!     real128    NaN      T  7FFF8000000000000000000000000000
!  complex 64    NaN      T                          7FC00000
!  complex128    NaN      T                  7FF8000000000000
!  complex256    NaN      T  7FFF8000000000000000000000000000

use, intrinsic :: iso_fortran_env, only: real32, real64, real128
use, intrinsic :: iso_fortran_env, only: int32, int64
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan, ieee_is_nan
implicit none (type, external)

real(real32) :: nan_real32
real(real64) :: nan_real64
real(real128) :: nan_real128
complex(real32) :: nan_complex64
complex(real64) :: nan_complex128
complex(real128) :: nan_complex256

integer(int32) :: ISP
integer(int64) :: IDP
character(*), parameter :: fmt='(A8,I3,2X,F5.1,6X,L1,2X,Z32)'


! this is the cross platform way to get NaN on modern compilers including gfortran and ifort.
nan_real32 = ieee_value(0.,ieee_quiet_nan)
nan_real64 = ieee_value(0.,ieee_quiet_nan)
nan_real128 = ieee_value(0.,ieee_quiet_nan)
nan_complex64 = ieee_value(0., ieee_quiet_nan)
nan_complex128 = ieee_value(0.,ieee_quiet_nan)
nan_complex256 = ieee_value(0.,ieee_quiet_nan)

! --------- print results

ISP = transfer(nan_real32, ISP)
IDP = transfer(nan_real64, IDP)

print '(A10,A8,A8,A28)','IEEE', 'value', 'isnan', 'hex'
print fmt,'real',storage_size(nan_real32), nan_real32, ieee_is_nan(nan_real32), ISP
print fmt,'real',storage_size(nan_real64), nan_real64, ieee_is_nan(nan_real64), IDP
print fmt,'real',storage_size(nan_real128),nan_real128, ieee_is_nan(nan_real128), nan_real128

print fmt,'complex',storage_size(nan_complex64),real(nan_complex64),ieee_is_nan(real(nan_complex64)),nan_complex64
print fmt,'complex',storage_size(nan_complex128),real(nan_complex128),ieee_is_nan(real(nan_complex128)),nan_complex128
print fmt,'complex',storage_size(nan_complex256),real(nan_complex256),ieee_is_nan(real(nan_complex256)),nan_complex256


end program
