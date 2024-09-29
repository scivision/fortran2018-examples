set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine poly(A)
  intrinsic :: rank
  real, intent(in) :: A(:)
  real :: B(rank(A))
  B = A
end subroutine"
f2018rank)
