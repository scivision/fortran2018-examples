!! demonstrates appending to a text file in Fortran
!! each "logger()" call starts a new line in the text file.
implicit none

integer :: u, i
character(*), parameter :: logfn = 'test_append.txt'
character(*), parameter :: pithy(3) = ['Hello    ', 'I like   ', 'to append']
character(len(pithy(1))) :: buf

call unlink(logfn)

do i = 1,size(pithy)
  call logger(pithy(i), logfn)
enddo

open(newunit=u, file=logfn, status='old', action='read', form='formatted')
do i = 1,size(pithy)
  read(u, '(A)') buf
  if (buf /= pithy(i)) error stop buf
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


subroutine logger(logstr, filename)

character(*), intent(in) :: logstr
character(*), intent(in):: filename

open(newunit=u, file=filename, status='unknown', form='formatted', access='stream', &
  position='append')

write(u,'(A)') logstr
close(u)

end subroutine logger

end program
