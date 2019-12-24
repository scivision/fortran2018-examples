module sleep_std
!! uses unistd.h or Windows.h for Fortran standard compliant sleep.
!! sleep() is a GNU extension, not standard Fortran.
use, intrinsic:: iso_c_binding, only: c_int

implicit none

private

interface

#ifdef _WIN32

subroutine system_sleep(ms) bind (C, name='Sleep')
import c_int
integer(c_int), value, intent(in) :: ms
end subroutine system_sleep

#else

subroutine system_sleep(us) bind (C, name='usleep')
import c_int
integer(c_int), value, intent(in) :: us
end subroutine system_sleep

#endif

end interface

public :: sleep_millisec

contains


subroutine sleep_millisec(t)
integer, intent(in) :: t
integer(c_int) :: tsys

#ifdef _WIN32
tsys = int(t, c_int)
#else
tsys = int(t, c_int) * 1000
#endif

call system_sleep(tsys)

end subroutine sleep_millisec

end module sleep_std