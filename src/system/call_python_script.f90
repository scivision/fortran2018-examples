program call_python
!! demos calling a Python script, without crashing Fortran program if Python interpreter is not found.
!! this technique works in general, as Fortran will crash if calling a non-existant program
!! without exitstat= and/or cmdstat= parameter

implicit none

character(:), allocatable :: cmd, buf
integer :: ierr, icerr, L

valgrind : block

cmd = "import os; print(f'{os.cpu_count()} CPUs detected by Python')"

call get_command_argument(1, length=L, status=ierr)
if (ierr /= 0) error stop "please specify Python interpreter as first argument"
allocate(character(L) :: buf)
call get_command_argument(1, value=buf)

buf = trim(buf) // ' -c "' // cmd // '"'

print '(a)', trim(buf)

call execute_command_line(buf, exitstat=ierr, cmdstat=icerr)
if (icerr/=0) error stop "Python interpreter not runnable"
if (ierr/=0) error stop "Python script failed"

end block valgrind

end program
