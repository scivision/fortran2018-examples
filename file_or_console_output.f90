program file_or_console
use, intrinsic:: iso_fortran_env, only: stdout=>output_unit

implicit none

character(:), allocatable :: filename
character(256) :: buf
integer :: i, u

call get_command_argument(1,buf,status=i)
if (i==0) then
  filename = trim(buf)  ! Fortran 2003 auto-allocate
  print *, 'writing to ',filename
  open(newunit=u, file=filename, form='formatted')
else
  u = stdout
endif

i = 3 ! test data

write(u,*) i, i**2, i**3

if (u /= stdout) close(u)   ! closing stdout can disable text console output
 
print *,'goodbye'

! end program implies closing all file units, but here we close in case you'd use in subprogram (procedure), where the file reference would persist.
end program
