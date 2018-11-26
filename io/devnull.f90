program nulltest
use, intrinsic:: iso_fortran_env, only: int64, wp=>real32
implicit none
! Benchmarks platform independent null file writing behavior
! NUL or NUL: works on Windows 10
! /dev/null is used for Mac, Linux, BSD, Unix, WSL, Cygwin...
!
! Flush() is used to avoid merely buffering the data, giving artificial results.
! in a real program, the amount of data written to disk is substantial 
! on each iteration, and the buffer would naturally get flushed.
! Yes, the benchmark is more aggressive than normal use--that's why 
! filesystem buffering is used by Fortran and programs in general.
!
! The point of this program is to show that by inserting '/dev/null' 
! as the filename for file outputs you never use, big speedups can result 
! from modifying a single parameter (the file name).
! This saves you from commenting out lines, using IF statements and possibly
! making mistakes in doing so.
! 
!
character(*),parameter :: nulunix='/dev/null', nulwin='NUL',fout='out.txt'
integer,parameter :: Nrun=1000
integer :: ios,u
real(wp) :: tnul, tscratch, tfile

!---  BENCHMARK NUL -----------
! status='old' is used as a failsafe, to avoid creating an actual file 
! in case of mistake. It is not necessary to specify status='old'.
open(newunit=u,file=nulunix,status='old',iostat=ios, action='write')
if (ios /= 0) open(newunit=u,file=nulwin,status='old',iostat=ios, action='write')
if (ios /= 0) error stop 'could not open a NULL file handle'

tnul = writetime(u,Nrun)
print '(A10,F10.3,A)','nul: ',tnul,' ms'
!---- BENCHMARK SCRATCH --------------
open(newunit=u,status='scratch')
tscratch = writetime(u,Nrun)
print '(A10,F10.3,A)','scratch: ',tscratch,' ms'
!---- BENCHMARK FILE --------
! note that open() default position=asis, access=sequential
open(newunit=u,status='replace',file=fout)
tfile = writetime(u,Nrun)
print '(A10,F10.3,A)','file: ',tfile,' ms'


contains

real(wp) function writetime(u,Nrun)

  integer, intent(in) :: u,Nrun
  integer(int64) :: tic,toc,tmin, rate
  integer, volatile :: i
  integer j

  tmin  = huge(0_int64) ! need to avoid SAVE behavior by not assigning at initialization
  call system_clock(count_rate=rate)

  do j=1,3
    call system_clock(tic)
    do i=1,Nrun
      write(u,*) 'into nothingness I go....',i
      flush(u)
    enddo
    call system_clock(toc)
    if (toc-tic < tmin) tmin = toc-tic
  enddo

  writetime = tmin / rate
  close(u)

end function writetime

end program
