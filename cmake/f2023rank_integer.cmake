set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
real, rank(2) :: a
!! Equivalent to real :: a(:,:)
end program"
f2023rank_integer)
