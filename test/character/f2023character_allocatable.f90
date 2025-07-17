program test
use, intrinsic :: iso_fortran_env, only: error_unit
character(:), allocatable :: scalar
integer :: L

! allocate(character(8000) :: scalar)  !> no longer needed in Fortran 2023

call get_command(scalar)
!! e.g. Gfortran 13:
!!   Fortran runtime error: Allocatable actual argument 'scalar' is not allocated


if (.not. allocated(scalar)) error stop 'F2023 auto-allocate on intrinsic assignment failed'

call get_command(length=L)
if (L /= len_trim(scalar)) then
  write(error_unit, '(a,i0,a,i0)') 'F2023 get_command length mismatch: ', L, ' /= ', len_trim(scalar)
  error stop
endif

print '(a)', 'OK: ' // scalar

end program
