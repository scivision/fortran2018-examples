program one_plus_one

use add_dummy, only : add_one

implicit none (type, external)

if (add_one(1) /= 2) error stop "1+1 = 2"

end program
