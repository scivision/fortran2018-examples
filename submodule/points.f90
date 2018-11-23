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

program submod_demo

use points, only: point, point_dist
implicit none

 type(point) :: a, b
 real :: dist

a = point(1,1)
b = point(3,5)

dist = point_dist(a,b)

print *,'distance between points',dist


end program
