program openreadonly

implicit none

character(len=*),parameter :: fnro='ro.txt'
character(len=80) :: readout
integer :: u,ios
logical :: fexist

!--- show read only file by filesystem is not safe from deletion ----
! e.g. chmod -w ro.txt, is overridden by Fortran like rm -f

call createro(fnro)

 call unlink(fnro,ios)
 if (ios.ne.0) error stop 'could not delete readonly file'
 print *,'deleted read-only: ',fnro
!----------- show delete on close
call createro(fnro)

open(newunit=u, file=fnro, form='formatted', status='old', iostat=ios, action='read')
 if (ios.ne.0) error stop 'could not open readonly file to read'

 read(u, iostat=ios, fmt=*) readout
 if (ios.ne.0) error stop 'could not read file'
! ios=0 for normal read reaching end of file.

 print*,readout

 close(u, status='delete') 

inquire(file=fnro, exist=fexist)

print *,fnro,' exists? ',fexist 

end program


subroutine createro(fn)
implicit none
! creates readonly file 
character(len=*),intent(in) :: fn
character(len=*),parameter :: txt='i am read only'
integer u,ios

open(newunit=u, file=fn, form='formatted', status='unknown', iostat=ios, action='write')
 if (ios.ne.0) error stop 'could not create readonly file'

call chmod(fn,'-w',ios)
 if (ios.ne.0) error stop 'could not create readonly file'

write(u,iostat=ios,fmt=*) txt
 if (ios.ne.0) error stop 'could not write file'

 close(u)

print*,'created read-only: ',fn

end subroutine
