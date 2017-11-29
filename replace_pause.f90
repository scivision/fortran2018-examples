program replace_pause
! demostrates replacement of obsolete Fortran 66 "pause" statement
! https://www.scivision.co/upgrade-obsolete-fortran-pause/
use, intrinsic:: iso_fortran_env, only: stdin=>input_unit
implicit none

character(80) :: userinp

!---- (1) just wait for user to press Enter, ignoring text input
print *, 'Now I am waiting for you to push Enter.'
read(stdin,*)
print *, 'OK, now I am moving on to the next example.'


!---- (2) wait for user to type text, that's assigned to a variable

print *, 'Type something at me, then push Enter.'
read(stdin,*) userinp
print *, 'You typed: ',userinp

!---- (3) allow a system command to be executed (like very old programs used)
! this isn't implemented due to the risk of free-form text input.

end program
