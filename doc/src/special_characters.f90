program special_char
! This program shows a few special ASCII characters in Fortran.
! https://en.wikipedia.org/wiki/ASCII#Character_groups

character, parameter :: &
nul = char(0), &
etx = char(3), &
tab = char(9), &
backslash = char(92)   ! necessary for strict compilers like PGI and Flang in strings

print *, 'null'
print '(A1)', nul

print *, 'etx'
print '(A1)', etx

print *, 'tab'
print '(A1)', tab

print *, 'backslash'
print '(A1)', backslash

end program
