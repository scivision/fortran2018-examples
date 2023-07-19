program AckermannPeter

!! two-argument Ackermann–Péter function
!! https://en.wikipedia.org/wiki/Ackermann_function

implicit none

integer :: Ack
integer, parameter :: M=3, N=5

print '(a,i0,a,i0)', "recursive two-argument Ackermann–Péter function, M=", M, ", N=", N

print *, Ap(M, N)

contains

recursive pure integer function Ap(m, n) result(A)
integer, intent(in) :: m,n

if (m == 0) then
  A = n+1
elseif (n == 0) then
  A = Ap(m-1, 1)
else
  A = Ap(m-1, Ap(m, n-1))
end if
end function Ap

end program AckermannPeter
