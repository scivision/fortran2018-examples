program nml
!! example of using namelist .nml in modern Fortran
!! here, we didn't specify "bar" in config.nml, so default values are used.
implicit none

character(*), parameter :: conffile = 'config.nml'
real :: x(3), y, z, a, b, c
integer :: u

namelist /foo/ x, y, z
namelist /bar/ a, b

!> set default values
x = [1., -1., 3.]
y = 2.
z = 3.
a = 4.
b = 5.

!> read values from config.nml, if present
open(newunit=u, file=conffile, action='read')
read(u, nml=foo)
read(u, nml=bar)
close(u)

c = sum(x) + y + z + a + b

if (abs(c-33.) > epsilon(c)) error stop 'config.nml not read properly'

end program
