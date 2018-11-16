program nulltest
use, intrinsic:: iso_fortran_env, only: int64
implicit none

integer(int64) :: tic,toc,rate
character(*), parameter :: nulunix='/dev/null', nulwin='NUL',fout='out.txt'
integer, parameter :: N=1000
integer :: ios,u,i
real :: tnul, tscr

! --- benchmark NUL
call system_clock(tic,count_rate=rate)

open(newunit=u,file=nulunix,status='replace',iostat=ios, action='write')
if (ios /= 0) open(newunit=u,file=nulwin,status='replace',iostat=ios, action='write')
if (ios /= 0) error stop 'could not open a NULL file handle'

do i = 1,N
    write(u,*) 'blah blah blah'
    flush(u)
enddo
close(u) 
call system_clock(toc)

tnul = (toc-tic)/real(rate)

print *,tnul,' seconds to write to NUL'

!---- benchmark scratch
call system_clock(tic)
open(newunit=u, status='scratch')
do i = 1,N
    write(u,*) 'blah blah blah'
    flush(u)
enddo
close(u)
call system_clock(toc)

tscr = (toc-tic)/real(rate)


print *,tscr,' seconds to write to scratch file'


print '(A,F7.3,A)','NUL is ',tscr/tnul,' times faster than scratch.'

end program
