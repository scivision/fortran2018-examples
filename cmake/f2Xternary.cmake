check_source_compiles(Fortran
"program tern

real :: a, value

value = ( a > 0.0 ? a : 0.0)

end program
"
f2Xternary
)
