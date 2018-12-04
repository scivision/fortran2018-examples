module Ackp
implicit none
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

end module Ackp


program AckermannPeter
use Ackp
implicit none

integer :: Ack, M, N
character(8) :: buf

if (command_argument_count() /= 2) stop 'input M,N positive integers'

call get_command_argument(1, buf)
read(buf,*) M

call get_command_argument(2, buf)
read(buf, *) N

Ack = Ap(M, N)

print *, Ack
end program AckermannPeter


