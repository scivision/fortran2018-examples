set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# https://wg5-fortran.org/N2201-N2250/N2212.pdf
# section 9.2

check_source_compiles(Fortran "program test
enumeration type :: colour
 enumerator :: red, orange, green
 end enumeration type
end program"
f2023enumeration)
