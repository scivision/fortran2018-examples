program float_prec
use,intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, qp=>real128, stderr=>error_unit
implicit none

real(sp) :: pi32 = 4*atan(1.0_sp)
real(dp) :: pi64 = 4*atan(1.0_dp)
real(qp) :: pi128 = 4*atan(1.0_qp)

if (sizeof(pi64) /= 8) then
    write(stderr,*) 'expected 8-byte real but you have real bytes: ', sizeof(pi64)
    error stop
endif

if (sizeof(pi32) /= 4) then
    write(stderr,*) 'expected 4-byte real but you have real bytes: ', sizeof(pi32)
    error stop
endif

if (sizeof(pi128) /= 16) then
    write(stderr,*) 'expected 16-byte real but you have real bytes: ', sizeof(pi128)
    error stop
endif

print *,'32-bit PI',pi32
print *,'64-bit PI',pi64
print *,'128-bit PI',pi128

! output should be:
! 32-bit PI   3.14159274    
! 64-bit PI   3.1415926535897931     
! 128-bit PI   3.14159265358979323846264338327950280 

! both ifort and gfortran allows "q" to specify real128 literal, "d" to specify real64 literal, and "e" for real32 literal.

! One should use "e" as the separator and a trailing _wp to avoid silent type conflicts

! this line is only true for default real32
print *,3.14159265358979323846264338327950280 == 3.14159274

end program
