program special_char
! This program shows a few special ASCII characters in Fortran.
! https://en.wikipedia.org/wiki/ASCII#Character_groups

use, intrinsic:: iso_fortran_env, only: stdout=>error_unit
character, parameter :: &
nul = char(0), &
etx = char(3), &
tab = char(9)

print *, 'null'
write(stdout,'(A1)') nul

print *, 'etx'
write(stdout,'(A1)')  etx

print *, 'tab'
write(stdout,'(A1)') tab

end program
