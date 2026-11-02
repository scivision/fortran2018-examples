set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
real :: a
print *, typeof(a)
contains
subroutine work(a)
typeof(a) :: t
end subroutine
end program
"
f2023typeof)
