program float_prec
use,intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, qp=>real128, stderr=>error_unit, i64=>int64
implicit none

! shows pitfall of not being mindful with input Kind

! "HUGE(X) returns the largest number that is not an infinity in the type of X"

real(sp) :: huge32 = huge(1.0_sp)
real(dp) :: huge64 = huge(1.0_dp)
real(qp) :: huge128 = huge(1.0_qp)
integer(i64) :: hugeint64 = huge(1_i64)

if (sizeof(huge64) /= 8) then
    write(stderr,*) 'expected 8-byte real but you have real bytes: ', sizeof(huge64)
    error stop
endif

if (sizeof(huge32) /= 4) then
    write(stderr,*) 'expected 4-byte real but you have real bytes: ', sizeof(huge32)
    error stop
endif

if (sizeof(huge128) /= 16) then
    write(stderr,*) 'expected 16-byte real but you have real bytes: ', sizeof(huge128)
    error stop
endif

if (sizeof(hugeint64) /= 8) then
    write(stderr,*) 'expected 8-byte integer but you have integer bytes: ', sizeof(hugeint64)
    error stop
endif

print *,'32-bit Huge',huge32
print *,'64-bit Huge',huge64
print *,'128-bit Huge',huge128
print *,'64-bit Huge Integer',hugeint64

print *,'kinds  sp dp qp i64'
print *,sp,dp,qp,i64

! output should be:
! 32-bit Huge   2.14748365E+09
! 64-bit Huge   9.2233720368547758E+018
! 128-bit Huge   1.70141183460469231731687303715884106E+0038
! 64-bit Huge Integer  9223372036854775807


end program
