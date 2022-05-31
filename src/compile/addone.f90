module add_dummy

implicit none (type, external)

contains

elemental integer function add_one(x) result (y)
integer, intent(in) :: x

y = x + 1

end function

end module add_dummy
