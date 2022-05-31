program print_vs_write
!! Fortran 2003 standard states that
!!  print *,
!!  write (*,*)
!! are equivalent. Let's show this via looking at disassembler code across compilers.
!! Let's also see what happens with "flush"
!!
!! Result: assembly output is identical with 3 types of print statements.

use, intrinsic:: iso_fortran_env, only: stdout=>output_unit

implicit none (type, external)


print *,'☀ ☁ ☂ ☃ ☄'

!write(stdout, *) '☀ ☁ ☂ ☃ ☄'

!write(*,'(A)') '☀ ☁ ☂ ☃ ☄'

flush(stdout)

! this obviously generates distinct assembly
! write(stdout, '(A)', advance='no') '☀ ☁ ☂ ☃ ☄'


end program
