program nulltest
use, intrinsic :: iso_fortran_env, only : dp=>REAL64
implicit none
! this program does platform independent null file writing behavior
! NUL or NUL: works on Windows 10
! Unix is used for Mac, Linux, BSD, Unix, WSL, Cygwin...
character(len=*),parameter :: nulunix='/dev/null', nulwin='NUL',fout='out.txt'
integer,parameter :: Nrun=10000000
integer ios,u
character(len=80) afn
real(dp) tnul, tscratch, tfile, writetime

!---  BENCHMARK NUL -----------
open(newunit=u,file=nulunix,status='old',iostat=ios)
if (ios.ne.0) open(newunit=u,file=nulwin,status='old',iostat=ios)
if (ios.ne.0) error stop 'could not open a NULL file handle'

tnul = writetime(u,Nrun)
print *,'nul: ',tnul,' ms.'
!---- BENCHMARK SCRATCH --------------
open(newunit=u,status='scratch')
tscratch = writetime(u,Nrun)
print *,'scratch: ',tscratch,' ms.'
!---- BENCHMARK FILE --------
open(newunit=u,status='unknown',file=fout)
tfile = writetime(u,Nrun)
print *,'file: ',tfile,' ms.'


end program

real(dp) function writetime(u,Nrun)
use, intrinsic :: iso_fortran_env, only : dp=>REAL64,i64=>INT64
use perf, only : init_random_seed, sysclock2ms
implicit none
integer, intent(in) :: u,Nrun
integer(i64) :: tic,toc,tmin
integer, volatile :: i
integer j

tmin  = huge(0_i64) ! need to avoid SAVE behavior by not assigning at initialization

do j=1,3
    call system_clock(tic)
    do i=1,Nrun
        write(u,*) 'into nothingness I go....',i
    enddo
    call system_clock(toc)
    if (toc-tic < tmin) tmin = toc-tic
enddo

writetime = sysclock2ms(tmin)
close(u)

end function
