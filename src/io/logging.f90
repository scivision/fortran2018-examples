module logging

use, intrinsic :: iso_fortran_env, only: int32, int64, real32, real64, stderr=>error_unit

implicit none (type, external)

contains

subroutine logger(val, filename)
!! polymorphic logging to text file, appending new values line by line.
!! logs to disk, auto-creating filename if not given

class(*), intent(in) :: val
character(*), intent(in), optional :: filename

character (:), allocatable :: logfn

if(present(filename)) then
  logfn = trim(filename)
else
  logfn = 'debug.log'
endif

block
  integer :: u
  open(newunit=u, file=logfn, status='unknown', form='formatted', access='stream', &
    position='append')

  select type (val)
  type is (character(*))
    write(u,'(A)') val
  type is (real(real32))
    write(u,'(F0.7)') val
  type is (real(real64))
    write(u,'(F0.15)') val
  type is (integer(int32))
    write(u,'(I0)') val
  type is (integer(int64))
    write(u,'(I0)') val
  type is (logical)
    write(u,'(L1)') val
  class default
    write(stderr, *) 'logging error: could not log unknown type/kind'  ! can't use val here
  end select

  close(u)
end block

end subroutine logger

end module logging
