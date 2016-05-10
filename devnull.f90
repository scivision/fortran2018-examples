program nulltest
! this program does platform independent null file writing behavior,
! on windows via a scratch file since NUL doesn't seem to work on Windows 10

character(len=*),parameter :: nulunix='/dev/null'
integer ios,u
character(len=80) afn

open(newunit=u,file=nulunix,status='old',iostat=ios)
! if using Windows w/o Cygwin -- we make an auto-deleting file
if (ios.ne.0) open(u,status='scratch')

! just for curiousity, not needed
inquire(u,name=afn)
print *,'scratch filename used ',afn

!  working code here with write statements, etc.
write(u,*) 'into nothingness I go....'

close(10)

end program 
