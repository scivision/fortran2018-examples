program call_python
!! demos calling a Python script, without crashing Fortran program if Python interpreter is not found.
!! this technique works in general, as Fortran will crash if calling a non-existant program
!! without exitstat= and/or cmdstat= parameter

implicit none

character(:), allocatable :: cmd
character(1024) :: buf
integer :: ierr, icerr

cmd = "import os; print(f'{os.cpu_count()} CPUs detected by Python')"

call get_command_argument(1, buf, status=ierr)
if (ierr /= 0) error stop "please specify Python interpreter as first argument"

buf = trim(buf)//' -c "'//cmd//'"'

print '(a)', trim(buf)

call execute_command_line(buf, exitstat=ierr, cmdstat=icerr)
if (icerr/=0) error stop "Python interpreter not runnable"
if (ierr/=0) error stop "Python script failed"
end program
