set_property(DIRECTORY PROPERTY LABELS maximum)

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  set(long_flags -ffree-line-length-none)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray")
  set(long_flags -N 1023)
endif()
# Intel: Default 7200 max line length  https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/compiler-reference/compiler-limits.html
# NVHPC: Default ~1000 max line length
# Flang/AOCC: Default 1000 max line length


set(CMAKE_REQUIRED_FLAGS ${long_flags})

string(RANDOM LENGTH 966 _long)

check_source_compiles(Fortran
[=[
program long
implicit none
character(*), parameter :: a = "${_long}"
end program
]=]
long_line
)

set(CMAKE_REQUIRED_FLAGS)

# --- long module name

set(_alpha "abcdefghijklmnopqrstuvwxyz")

string(RANDOM LENGTH 63 ALPHABET ${_alpha} _name63)

check_source_compiles(Fortran
"program test
module ${_name63}
end module
end program"
module_63char
)

check_source_compiles(Fortran
"program test
real :: ${_name63}
end program"
variable_63char
)

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
submodule_63char
)
