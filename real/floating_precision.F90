program float_prec
use,intrinsic:: iso_fortran_env, stderr=>error_unit
implicit none (type, external)

real(real32) :: pi32 = 4*atan(1.0_real32)
real(real64) :: pi64 = 4*atan(1.0_real64)
#ifdef REAL128
real(real128) :: pi128 = 4*atan(1.0_real128)
#endif

print *,compiler_version()

if (storage_size(pi64) /= 64) then
    write(stderr,*) 'expected real64 but you have real bits: ', storage_size(pi64)
    error stop
endif
print *,'64-bit PI',pi64

if (storage_size(pi32) /= 32) then
    write(stderr,*) 'expected real32 but you have real bits: ', storage_size(pi32)
    error stop
endif
print *,'32-bit PI',pi32

#ifdef REAL128
if (storage_size(pi128) /= 128) then
    write(stderr,*) 'expected real128 but you have real bits: ', storage_size(pi128)
    error stop
endif
print *,'128-bit PI',pi128
#endif



! output should be:
! 32-bit PI   3.14159274
! 64-bit PI   3.1415926535897931
! 128-bit PI   3.14159265358979323846264338327950280

! both ifort and gfortran allows "q" to specify real128 literal, "d" to specify real64 literal, and "e" for real32 literal.

! One should use "e" as the separator and a trailing _wp to avoid silent type conflicts

! this line is only true for default real32
print *,'default real32  ',3.14159265358979323846264338327950280 == 3.14159274

end program
