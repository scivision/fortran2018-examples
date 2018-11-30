submodule (points) geo
contains
  module procedure point_dist
    distance = hypot(a%x - b%x, a%y - b%y)
  end procedure point_dist
end submodule geo

! Flang, PGI fail with
! 

! also tried below, with no change in Flang, PGI error:
!  module function point_dist(a,b) result(distance)
!    class(point), intent(in) :: a, b
!    real :: distance
!    distance = hypot(a%x - b%x, a%y - b%y)
!  end function point_dist
