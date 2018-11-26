program huge_prec
use,intrinsic:: iso_fortran_env, stderr=>error_unit
implicit none

! real128 is enabled but buggy in Gfortran 4.8. Better use Gfortran >= 5.

! shows pitfall of not being mindful with input Kind. Need to be decimal for real kinds!

! "HUGE(X) returns the largest number that is not an infinity in the type of X"

! Compare with S. 5.19, pg. 87 of "Introduction to Programming with Fortran: With Coverage of Fortran 90, 95, 2003, 2008 and 77", 3rd. Ed.,
! By Ian Chivers, Jane Sleightholme"

real(real32), parameter :: huge32 = huge(1.0_real32)
real(real64), parameter :: huge64 = huge(1.0_real64)
#if REAL128
real(real128), parameter :: huge128 = huge(1.0_real128)
complex(real128), parameter :: ch256 = (huge128,huge128)
#endif
integer(int64), parameter :: hugeint64 = huge(1_int64)

! check 32-bit real
if (storage_size(huge32) /= 32) then
    write(stderr,*) 'expected 32-bit real but have', storage_size(huge32),'bits.'
    stop 1
endif

if (huge32 /= 3.40282347E+38) write(stderr,*) 'warning: huge32 was',huge32,'instead of 3.40282347E+38'

print *,'32-bit real Huge',huge32


! Check 64-bit real
if (storage_size(huge64) /= 64) then
    write(stderr,*) 'expected 64-bit real but have', storage_size(huge64), 'bits.'
    stop 1
endif

if (huge64 /= 1.7976931348623157E+308_real64) write(stderr,*) 'warning: huge64 was ',huge64,'instead of 1.7976931348623157E+308'

print *,'64-bit real Huge',huge64

#if REAL128
! Check 128-bit real
if (storage_size(huge128) /= 128) then
    write(stderr,*) 'expected 128-bit real but have', storage_size(huge128),'bits.'
    stop 1
endif

if (huge128 /= 1.18973149535723176508575932662800702E+4932_real128) write(stderr,*) 'warning: huge128 was ',huge128,&
    'instead of 1.18973149535723176508575932662800702E+4932'
    
print *,'128-bit real Huge',huge128
    
! check 256-bit complex
if (storage_size(ch256) /= 256) then
    write(stderr,*) 'expected 256-bit complex but have', storage_size(ch256),'bits.'
    stop 1
endif

if (ch256 /= (huge128,huge128)) write(stderr,*) 'warning: complex256 was ',ch256,&
    'instead of (1.18973149535723176508575932662800702E+4932,1.18973149535723176508575932662800702E+4932)' 

print *,'256-bit complex huge',ch256,'consisting of',storage_size(ch256),'bits'
#endif

! Check 64-bit int
if (storage_size(hugeint64) /= 64) then
    write(stderr,*) 'expected 64-bit integer but have', storage_size(hugeint64), 'bits.'
    stop 1
endif

if (hugeint64 /= 9223372036854775807_int64) write(stderr,*) 'warning: hugeint64 was ',hugeint64,'instead of 9223372036854775807'

print *,'64-bit integer Huge',hugeint64


! Must use decimal point inside Huge() or you'll get INCORRECT:
! 32-bit Huge INCORRECT   2.14748365E+09
! 64-bit Huge INCORRECT  9.2233720368547758E+018
! 128-bit Huge INCORRECT  1.70141183460469231731687303715884106E+0038

! CORRECT
! 32-bit Huge   3.40282347E+38
! 64-bit Huge   1.7976931348623157E+308
! 128-bit Huge   1.18973149535723176508575932662800702E+4932
! 64-bit Huge Integer  9223372036854775807


end program
