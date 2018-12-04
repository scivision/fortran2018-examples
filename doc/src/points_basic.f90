module points
  
  interface
     module function point_dist(ax, ay, bx, by) result(distance)
       real, intent(in) :: ax, ay, bx, by
       real :: distance
     end function point_dist
  end interface
end module points


program submod_demo
  use, intrinsic :: iso_fortran_env, only: stderr=>error_unit
  use points, only: point_dist
implicit none

 real :: dist, ax, ay, bx, by

ax = 1.
ay = 1.
bx = 3.
by = 5.

dist = point_dist(ax,ay,bx,by)

print *,'distance', dist

if (abs(dist-4.47213602) >= 1e-5) then
  write(stderr,*) 'excessive error in computation'
  stop 1
endif

end program
