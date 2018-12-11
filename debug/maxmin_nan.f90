program nanmax

use, intrinsic :: ieee_arithmetic
real :: A(4), x, y, nan

nan = ieee_value(1., ieee_quiet_nan)

A = [0., 1., 2., nan]
print *, maxval(A)

x = -nan
y = 1.

print *, max(x,y)

print *,x

end program
