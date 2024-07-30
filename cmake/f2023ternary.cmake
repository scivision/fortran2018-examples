set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test

real :: a, value

value = ( a > 0.0 ? a : 0.0)

end program
"
f2023ternary
)
