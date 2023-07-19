check_source_compiles(Fortran
"program test
complex :: z
print *,z%re,z%im,z%kind
end program"
f18prop
)
