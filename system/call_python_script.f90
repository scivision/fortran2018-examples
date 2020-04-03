program call_python
!! demos calling a Python script, without crashing Fortran program if Python interpreter is not found.
!! this technique works in general, as Fortran will crash if calling a non-existant program
!! without exitstat= and/or cmdstat= parameter

use os_detect, only: getos
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none (external)


integer :: ierr, istat
character(:), allocatable :: cmd, oscmd, os
character(*), parameter :: exe='python3'

cmd = "import psutil; print(f'{psutil.virtual_memory().available} MB RAM free')"

select case (getos())
case('windows')
  oscmd = 'where '//exe
case('unix')
  oscmd = 'which '//exe
case default
  error stop 'unknown os'
end select

call execute_command_line(oscmd, cmdstat=ierr, exitstat=istat)
if (ierr/=0 .or. istat /= 0) error stop 'python not found'

call execute_command_line(exe//' -c "'//cmd//'"', cmdstat=ierr, exitstat=istat)
if (ierr/=0 .or. istat/=0) write(stderr,*) 'Python psutil not available'

end program