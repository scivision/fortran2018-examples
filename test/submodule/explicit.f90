module sm_exp

use, intrinsic :: iso_fortran_env

implicit none

interface
module subroutine sel(A)
CLASS(*), INTENT(INOUT) :: A
end subroutine sel
end interface


end module sm_exp


submodule (sm_exp) smode

implicit none

contains
module subroutine sel(A)
class(*), intent(inout) :: A

select type (A)
type is (real(real32))
 print *, 'real32'
type is (real(real64))
 print *, 'real64'
type is (integer(int32))
 print *, 'int32'
class default
 error stop 'unknown type'
end select

end subroutine sel

end submodule smode


program aaaa

use sm_exp

implicit none

real(real32) :: x
real(real64) :: x64

call sel(x)
call sel(x64)

end program
