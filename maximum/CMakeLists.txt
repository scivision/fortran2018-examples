include(CheckFortranSourceCompiles)

set(_alpha "abcdefghijklmnopqrstuvwxyz")

string(RANDOM LENGTH 63 ALPHABET ${_alpha} _name63)

check_fortran_source_compiles("
module ${_name63}
end
end" module_63char SRC_EXT f90)

check_fortran_source_compiles("
real :: ${_name63}
end" variable_63char SRC_EXT f90)

string(RANDOM LENGTH 63 ALPHABET ${_alpha} _name63a)

check_fortran_source_compiles("
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

end program" submodule_63char SRC_EXT f90)
