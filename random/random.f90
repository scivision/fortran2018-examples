module random

implicit none

interface
  module subroutine random_init()
  end subroutine
end interface

contains

impure elemental integer function randint(lo, hi)
integer, intent(in) :: lo, hi
real :: r

call random_number(r)

randint = floor(r * (hi + 1 - lo)) + lo

end function randint


end module random
