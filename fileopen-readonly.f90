program openreadonly

implicit none

character(len=*),parameter :: fn='uhoh.txt', fnro='ro.txt'
character(len=80) :: readout
character(len=*),parameter :: txt='hello'
integer :: u,ios
logical :: fexist
!---------- write test file ----------
 open(newunit=u,file=fn,form='formatted',status='unknown',iostat=ios,action='write')
 if (ios.ne.0) error stop 'could not open file to write'

 write(u,iostat=ios,fmt=*) txt
 if (ios.ne.0) error stop 'could not write file'

 close(u)

!--------- read test file ---------------
! fortran overrides the readonly status at close if "status='delete'" is specified.

 open(newunit=u, file=fn, form='formatted', status='old', iostat=ios, action='read')
 if (ios.ne.0) error stop 'could not open file to read'

 read(u, iostat=ios, fmt=*) readout
 if (ios.ne.0) error stop 'could not read file'
! ios=0 for normal read reaching end of file.

 print*,readout

 close(u, status='delete') 

inquire(file=fn, exist=fexist)

print *,fn,' exists? ',fexist 

!--- show read only file by filesystem is not safe from deletion ----
! e.g. chmod -w ro.txt, is overridden by Fortran like rm -f

open(newunit=u, file=fnro, form='formatted', status='old', iostat=ios, action='read')
 if (ios.ne.0) error stop 'could not open readonly file to read'

 read(u, iostat=ios, fmt=*) readout
 if (ios.ne.0) error stop 'could not read file'
! ios=0 for normal read reaching end of file.

 print*,readout

 close(u, status='delete') 

inquire(file=fnro, exist=fexist)

print *,fn,' exists? ',fexist 

end program
