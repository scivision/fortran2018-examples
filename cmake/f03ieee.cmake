set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine r()
use, intrinsic :: ieee_arithmetic, only : ieee_next_after
print *, ieee_next_after(0., 0.)
end subroutine"
f03ieee
)
