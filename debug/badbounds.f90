program badbounds
!! This program should trigger array bounds checking

implicit none

real :: A(-1:2) = [-1,0,1,2]
real :: B(4)

integer :: i, j

i = -1
j = 2


j=j+1
A(j) = 3
!A(-2) = -2
print '(10F5.1)',A(i-1:j)

print *, A

end program


