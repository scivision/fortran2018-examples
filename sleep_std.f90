program stdsleep
use, intrinsic:: iso_c_binding, only: c_int
implicit none

interface
     subroutine usleep(us) bind (C)
      import c_int
      integer(c_int), value :: us
    end subroutine usleep
end interface



integer(c_int), parameter :: us=500000

print *,'sleeping for ',us/1000,' milliseconds.'
call usleep(us)
print *,'what a nice nap. Goodbye.'



end program
