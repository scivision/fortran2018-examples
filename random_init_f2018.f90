program seed2018
! checks if your compiler has Fortran 2018 random_init()  (Gfortran 8.2 doesn't have it)
implicit none

call random_init()


end program
