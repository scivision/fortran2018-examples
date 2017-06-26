program prec
use,intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, qp=>real128, stderr=>error_unit, i64=>int64
implicit none

! shows pitfall of not being mindful with input Kind

! NOTE that 9/5.0_dp  /=  9/5.0, even when the assigned variable is real(dp) !!

real(sp) :: huge32 = 9/5.0_sp
real(dp) :: huge64 = 9/5.0_dp
real(qp) :: huge128 = 9/5.0_qp
integer(i64) :: hugeint64 = 9/5_i64

real(dp) :: imdouble = 9/5.

if (sizeof(imdouble) /= 8) then
    write(stderr,*) 'expected 8-byte real but you have real bytes: ', sizeof(huge64)
    error stop
endif

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

print *,'64-bit variable with 32-bit constants',imdouble
print *,'64-bit variable, 32-bit constants equal to all 64-bit constants?',imdouble==huge64
print *,'32-bit',huge32
print *,'64-bit',huge64
print *,'128-bit',huge128
print *,'64-bit Integer',hugeint64

print *,'kinds  sp dp qp i64'
print *,sp,dp,qp,i64

!  64-bit variable with 32-bit constants   1.7999999523162842     
! 64-bit variable, 32-bit constants equal to all 64-bit constants? F
! 32-bit   1.79999995    
! 64-bit   1.8000000000000000     
! 128-bit   1.80000000000000000000000000000000004      
! 64-bit Integer                    1
! kinds  sp dp qp i64
!           4           8          16           8
! Bit Patterns:
! 11011011111111111100110011001100110011000000000000000000000000000000
! 11011011111111111100110011001100110011001100110011001100110011001101


print *,'Bit Patterns:'

print '(B0)','64-bit variable with 32-bit constants',imdouble
print '(B0)','64-bit variable with 64-bit constants',huge64

end program
