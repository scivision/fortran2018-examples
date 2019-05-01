!! very simple demo of string to integer
implicit none

character(:), allocatable :: x
integer :: m, n

x = '42'

read(x,*) m
read(x,'(i2)') n

if(m/=n) error stop

print '(A,I3)', x//' =>',m

end program

