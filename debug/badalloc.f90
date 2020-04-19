program badbounds
!! This program should trigger array bounds checking (at runtime if not compile time)

use, intrinsic :: iso_fortran_env
implicit none (type, external)


real, allocatable :: A(:)

integer :: i, j

print *, compiler_version()

allocate(A(-1:2))

A(-1:2) = [-1,0,1,2]

i = -1
j = 2


j=j+1
A(j) = 3
A(-2) = -2
print '(10F5.1)',A(i-1:j)

print *, A

end program


