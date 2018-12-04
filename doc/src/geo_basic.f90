submodule (points) geo
contains
  module procedure point_dist
    distance = hypot(ax - bx, ay - by)
  end procedure point_dist
end submodule geo

