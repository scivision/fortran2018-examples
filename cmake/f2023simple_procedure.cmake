set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# https://wg5-fortran.org/N2201-N2250/N2212.pdf
# section 7.1

check_source_compiles(Fortran "program test

real :: x

x = real(2.)

contains

real simple function timestwo(x)
  real, intent(in) :: x
  timestwo = 2.0 * x
end function timestwo

end program"
f2023simple_procedure)
