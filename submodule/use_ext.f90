program use_ext
use constants, only: get_pi

implicit none (external)


print *,'using submodule, pi=',get_pi()

end program