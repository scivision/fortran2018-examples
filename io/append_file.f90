!! demonstrates appending to a text file in Fortran
!! using polymorphic input type. Logging float, int, character.
!! each "logger()" call starts a new line in the text file.
use, intrinsic :: iso_fortran_env, only: int32, int64, real32, real64
implicit none

integer :: u, i
character(*), parameter :: logfn = 'test_append.txt'
character(*), parameter :: pithy(3) = ['Hello    ', 'I like   ', 'to append']
character(*), parameter :: out_real(3) = ['42. ', '100.', '200.']
character(*), parameter :: out_logical(2) = ['T','F']
character(*), parameter :: out_int(3) = ['42 ', '100', '200']
character(len(pithy(1))) :: buf
integer(int32) :: in_int(3)=[42,100,200]
real(real32) :: in_real(3) =[42.,100.,200.]
logical :: in_logical(2) = [.true., .false.]

call unlink(logfn)

do i = 1,size(pithy)
  call logger(pithy(i), logfn)
enddo

open(newunit=u, file=logfn, status='old', action='read', form='formatted')
do i = 1,size(pithy)
  read(u, '(A)') buf
  if (buf /= pithy(i)) error stop 'CHARACTER: file read did not match write'
enddo
close(u)

!=================
call unlink(logfn)

do i = 1,size(in_real)
  call logger(in_real(i), logfn)
enddo

open(newunit=u, file=logfn, status='old', action='read', form='formatted')
do i = 1,size(in_real)
  read(u, '(A)') buf
  if (buf /= out_real(i)) error stop 'REAL32: file read did not match write'
enddo
close(u)

!=================
call unlink(logfn)

do i = 1,size(in_logical)
  call logger(in_logical(i), logfn)
enddo

open(newunit=u, file=logfn, status='old', action='read', form='formatted')
do i = 1,size(in_logical)
  read(u, '(A)') buf
  if (buf /= out_logical(i)) error stop 'LOGICAL: file read did not match write'
enddo
close(u)

!=================
call unlink(logfn)

do i = 1,size(in_int)
  call logger(in_int(i), logfn)
enddo

open(newunit=u, file=logfn, status='old', action='read', form='formatted')
do i = 1,size(in_int)
  read(u, '(A)') buf
  if (buf /= out_int(i)) error stop 'INT32: file read did not match write'
enddo
close(u)

contains

subroutine unlink(filename)
!! deletes file in Fortran standard manner.
!! Silently continues if file doesn't exist or cannot be deleted.
character(*), intent(in) :: filename
integer :: i

open(newunit=u, file=filename, iostat=i)
close(u, status='delete', iostat=i)

end subroutine unlink


subroutine logger(val, filename)

class(*), intent(in) :: val
character(*), intent(in):: filename

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

end program
