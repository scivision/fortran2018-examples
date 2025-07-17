set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# https://wg5-fortran.org/N2201-N2250/N2212.pdf
# section 8.1

check_source_compiles(Fortran "program test
program test
real :: A(4, 4)
real :: x

x = A(@[3,2])
! Array element, equivalent to A(3, 2)
end program"
f2023array_multiple_subscript)
