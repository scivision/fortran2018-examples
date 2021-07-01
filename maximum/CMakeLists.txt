set(_alpha "abcdefghijklmnopqrstuvwxyz")

string(RANDOM LENGTH 63 ALPHABET ${_alpha} _name63)

check_source_compiles(Fortran
"program test
module ${_name63}
end module
end program"
module_63char)

check_source_compiles(Fortran
"program test
real :: ${_name63}
end program"
variable_63char)

string(RANDOM LENGTH 63 ALPHABET ${_alpha} _name63a)

check_source_compiles(Fortran
"program test
module ${_name63}
interface
module subroutine nothing
end subroutine nothing
end interface
contains
subroutine nobody()
end subroutine nobody
end module ${_name63}

submodule (${_name63}) &
${_name63a}
contains
module procedure nothing
end procedure nothing
end submodule ${_name63a}

end program"
submodule_63char)
