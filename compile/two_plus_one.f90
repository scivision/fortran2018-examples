program two_plus_one

use add_dummy, only : add_one

implicit none (type, external)

if (add_one(2) /= 3) error stop "2+1 = 3"

end program
