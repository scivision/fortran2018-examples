module sm_proc

use, intrinsic :: iso_fortran_env

implicit none

interface
module subroutine sel(A)
CLASS(*), INTENT(INOUT) :: A
end subroutine sel
end interface


end module sm_proc


submodule (sm_proc) smod

implicit none

contains
module procedure sel

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

end procedure sel

end submodule smod


program aaaa

use sm_proc

implicit none

real(real32) :: x
real(real64) :: x64

call sel(x)
call sel(x64)

end program
