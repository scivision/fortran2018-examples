set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran
"program test
intrinsic :: random_init
call random_init(.false., .false.)
end program"
f18random
)
