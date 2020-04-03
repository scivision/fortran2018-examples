module logging

use, intrinsic :: iso_fortran_env, only: int32, int64, real32, real64
implicit none (external)

contains

subroutine logger(val, filename)
!! polymorphic logging to text file, appending new values line by line.

class(*), intent(in) :: val
character(*), intent(in):: filename

integer :: u

open(newunit=u, file=filename, status='unknown', form='formatted', access='stream', &
  position='append')

select type (val)
type is (character(*))
  write(u,'(A)') val
type is (real(real32))
  write(u,'(F0.0)') val
type is (real(real64))
  write(u,'(F0.0)') val
type is (integer(int32))
  write(u,'(I0)') val
type is (integer(int64))
  write(u,'(I0)') val
type is (logical)
  write(u,'(L1)') val
end select

close(u)

end subroutine logger

end module logging
