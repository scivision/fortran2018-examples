module demo
real, parameter :: pi = 4.*atan(1.)
real :: tau

interface
  module subroutine hello(pi,tau)
    real, intent(in) :: pi
    real, intent(out) :: tau
  end subroutine hello
end interface

contains 

end module demo


program sm

use demo

call hello(pi, tau)

print *,'pi=',pi, 'tau=', tau

end program
