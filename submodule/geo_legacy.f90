submodule (points) geo_legacy
contains
  module procedure point_dist
    distance = sqrt((a%x - b%x)**2 + (a%y - b%y)**2)
  end procedure point_dist
end submodule geo_legacy
