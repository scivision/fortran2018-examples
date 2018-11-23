module demod
real, parameter :: pi = 4.*atan(1.)
real :: tau
interface
module subroutine hello
end subroutine hello
end interface
contains
subroutine hellotau()
print *,'tau=',tau
end subroutine hellotau
end module demod

submodule (demod) submod
contains
module procedure hello
print *,'pi=',pi
tau = 2*pi
end procedure hello
end submodule submod

program sm
use demod
call hello
call hellotau
end
