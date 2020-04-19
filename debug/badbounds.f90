program badbounds
!! This program should trigger array bounds checking

implicit none (type, external)


real :: A(-1:2) = [-1,0,1,2]

integer :: i, j

i = -1
j = 2


j=j+1
A(j) = 3
!A(-2) = -2
print *,A(i-1:j)

print *, A

end program


