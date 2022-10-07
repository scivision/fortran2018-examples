check_fortran_source_compiles(
"program test
complex :: z
print *,z%re,z%im,z%kind
end program"
f18prop
SRC_EXT f90
)
