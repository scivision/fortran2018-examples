program open_ro
!! NOTE: chmod is non-standard, and will crash ifort runtime.

implicit none (type, external)

external :: unlink

character(*),parameter :: fnro='ro.txt'
logical :: exists

call create_ro(fnro)
call unlink(fnro)

inquire(file=fnro, exist=exists)
if(exists) error stop 'could not delete file'

print *,'deleted read-only: ',fnro

contains


subroutine create_ro(fn)
!! creates  file to delete
character(*),intent(in) :: fn
character(*),parameter :: txt='i am read only'
integer :: u

open(newunit=u, file=fn, form='formatted', status='unknown', action='write')

write(u, *) txt

close(u)

print *,'created read-only: ',fn

end subroutine create_ro




end program
