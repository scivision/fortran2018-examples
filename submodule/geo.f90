submodule (points) geo
contains
  module procedure point_dist
    distance = hypot(a%x - b%x, a%y - b%y)
  end procedure point_dist
end submodule geo
