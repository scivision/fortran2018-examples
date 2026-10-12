program unused_variable
!! demonstrates code that reliably triggers a compiler warning
!! (unused variable), e.g. with gfortran -Wall or ifort -warn all
implicit none

integer :: never_used

print *, 'This program compiles fine, but "never_used" triggers a warning.'

end program
