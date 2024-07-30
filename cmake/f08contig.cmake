set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# ifort-19 yes, Flang yes, NAG yes, gfortran-8 no, gfortran-9 yes
check_source_compiles(Fortran
"program test
intrinsic :: is_contiguous
print '(L1)', is_contiguous([0,0])
end program"
f08contig
)
