set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# https://wg5-fortran.org/N2201-N2250/N2212.pdf
# section 8.3 Using an integer constant to specify rank

# Supported by Intel oneAPI >= 2025.3.0
# not yet supporte by GCC 15.2.0 ...

check_source_compiles(Fortran "subroutine r(a)
real, rank(2) :: a
!! Equivalent to real :: a(:,:)
end subroutine"
f2023rank_integer)
