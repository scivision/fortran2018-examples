set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
use, intrinsic :: iso_fortran_env, only: real16
end program"
f2023real16
)
