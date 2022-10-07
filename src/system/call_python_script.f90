program call_python
!! demos calling a Python script, without crashing Fortran program if Python interpreter is not found.
!! this technique works in general, as Fortran will crash if calling a non-existant program
!! without exitstat= and/or cmdstat= parameter

implicit none

character(:), allocatable :: cmd
character(*), parameter :: exe='python'

cmd = "import os; print(f'{os.cpu_count()} CPUs detected')"

call execute_command_line(exe//' -c "'//cmd//'"')

end program
