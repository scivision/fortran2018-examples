module points
  type :: point
    real :: x, y
  end type point

  interface
     module function point_dist(a, b) result(distance)
       class(point), intent(in) :: a, b
       real :: distance
     end function point_dist
  end interface
end module points


submodule (points) geo
contains
  module procedure point_dist
    distance = hypot(a%x - b%x, a%y - b%y)
  end procedure point_dist
end submodule geo


program submod_demo
use, intrinsic :: iso_fortran_env, only: stderr=>error_unit
use points, only: point, point_dist
implicit none

 type(point) :: a, b
 real :: dist

a = point(1.,1.)
b = point(3.,5.)

dist = point_dist(a,b)

print *,'distance', dist

if (abs(dist-4.47213602) >= 1e-5) then
  write(stderr,*) 'excessive error in computation'
  stop 1
endif


end program
