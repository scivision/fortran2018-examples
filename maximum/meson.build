alpha = 'KgZ3zMXY2vBCqOgMGNkk5zJZ1MzXyHEE82KptTX0ozh9RdiG85UhBcYOzy1IoDZ'
alpha2 = 'KgZ3zMXY2vBCqOgMGNkk5zJZ1MzXyHEE82KptTX0ozh9RdiG85UhBcYOzy1IoDX'

fc = meson.get_compiler('fortran')

fc.compiles('''
module @0@
end
end'''.format(alpha),
name: 'module 63 char')

fc.compiles('''
real :: @0@
end'''.format(alpha),
name: 'variable 63 char')

fc.compiles('''
module @0@
interface
module subroutine nothing
end subroutine nothing
end interface
contains
subroutine nobody()
end subroutine nobody
end module @0@

submodule (@0@) &
@1@
contains
module procedure nothing
end procedure nothing
end submodule @1@

end program
'''.format(alpha,alpha2),
name: 'submodule 63 char')
