program statement_function
implicit none


integer :: f,i,j,k,n
! obsolete statement function (don't use)
f(n) = n+(i*j)**k

i=2
j=3
k=4

if (f(i-j) /= g(i-j,i,j,k)) error stop

contains

elemental integer function g(n,i,j,k)
!! use this instead of statement function
integer, intent(in) :: n,i,j,k
g = n+(i*j)**k
end function g

end program
