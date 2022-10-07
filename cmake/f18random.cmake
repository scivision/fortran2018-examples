check_fortran_source_compiles(
"program test
call random_init(.false., .false.)
end program"
f18random
SRC_EXT f90
)
