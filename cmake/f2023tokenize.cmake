set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
intrinsic :: tokenize
end program"
f2023tokenize
)
