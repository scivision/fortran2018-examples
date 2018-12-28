program call_python_script
!! demos calling a Python script, without crashing Fortran program if Python interpreter is not found.
!! this technique works in general, as Fortran will crash if calling a non-existant program.
use os_detect, only: getos
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

integer :: ierr
character(:), allocatable :: cmd, oscmd, os
character(*), parameter :: exe='python3'

cmd = "import psutil; print(f'{psutil.virtual_memory().available} MB RAM free')"

os = getos()
if (os=='windows') then
  oscmd = 'where '//exe
elseif(os=='unix') then
  oscmd = 'which '//exe
else
  error stop 'unknown os '//os
endif

call execute_command_line(oscmd, exitstat=ierr)

if (ierr==0) then
  call execute_command_line(exe//' -c "'//cmd//'"', exitstat=ierr)
endif
if (ierr/=0) write(stderr,*) 'Python psutil not available'

end program