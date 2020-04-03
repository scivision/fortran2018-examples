module random

  implicit none (external)

interface
  module subroutine rand_init(repeatable, image_distinct)
  logical, intent(in) :: repeatable, image_distinct
  end subroutine rand_init
end interface

contains

impure elemental integer function randint(lo, hi)
integer, intent(in) :: lo, hi
real :: r

call random_number(r)

randint = floor(r * (hi + 1 - lo)) + lo

end function randint


end module random
