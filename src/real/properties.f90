program prop
!! Show:
!! * %re and %im properties of real number in Fortran 2018
!! * %len property of character

use, intrinsic :: iso_fortran_env, only: real32
implicit none (type, external)

character(:), allocatable :: c
complex :: z

z = (1, 1.414)
c = 'hello'
c = 'hi'

print *, c, c%len
if (c%len /= len(c)) error stop 'character %len'


print *, z%re, z%im, z%kind
if (real32 /= z%kind) error stop 'kind mismatch'

end program
