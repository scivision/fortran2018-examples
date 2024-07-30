set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
complex :: z
print *, z%re, z%im, z%kind
end program"
f18prop
)
