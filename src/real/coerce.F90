program coerce
use,intrinsic:: iso_fortran_env, stderr=>error_unit
implicit none

real(real32) :: four32 = 2._real32 * 2._real32, four32coerce = 2*2
real(real64) :: four64 = 2._real64 * 2._real64, four64coerce = 2*2

print *,compiler_version()

if (four32 /= four32coerce) then
  write(stderr,*) 'expected real32 did not coerce: ', four32coerce
  error stop
endif
print *,'real(real32) = 4: ', four32coerce

if (four64 /= four64coerce) then
  write(stderr,*) 'expected real64 did not coerce: ', four64coerce
  error stop
endif
print *,'real(real64) = 4: ', four64coerce

#ifdef r128
block
real(real128) :: four128 = 2._real128 * 2._real128, four128coerce = 2*2

if (four128 /= four128coerce) then
  write(stderr,*) 'expected real128 did not coerce: ', four128coerce
  error stop
endif
print *,'real(real128) = 4: ', four128coerce
end block
#endif
!> what about through procedures

if (4*atan(1._real64) /= 4._real64 * atan(1._real64)) error stop 'function coerce'

if (2._real32 * 2._real64 /= 4._real64) error stop 'multiply upscale coerce'
!! this does not equal if value is float like 2.1_real32 * 2.1_real64

if (4._real64 / 2 /= 2._real64) error stop 'divide coerce'

end program
