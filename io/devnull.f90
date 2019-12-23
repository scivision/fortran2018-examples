use, intrinsic:: iso_fortran_env, only: int64, wp=>real64, stderr=>error_unit
implicit none
! Benchmarks platform independent null file writing behavior
! NUL: works on Windows 10
! /dev/null is used for Mac, Linux, BSD, Unix, WSL, Cygwin...
!
! Flush() is used to avoid merely buffering the data, giving artificial results.
! in a real program, the amount of data written to disk is substantial
! on each iteration, and the buffer would naturally get flushed.
! Yes, the benchmark is more aggressive than normal use--that's why
! filesystem buffering is used by Fortran and programs in general.
!
! The point of this program is to show that by inserting '/dev/null' or 'NUL'
! as the filename for file outputs you never use, big speedups can result
! from modifying a single parameter (the file name).
! This is generally true even for fast SSD.
! This saves you from commenting out lines, using IF statements and possibly
! making mistakes in doing so.
!
!
character(*),parameter :: fout='out.txt'
character(:), allocatable :: nullfile
character(2048) :: argv
integer,parameter :: Nrun=10000
integer :: ios,u
real(wp) :: tnul, tscratch, tfile

call get_command_argument(1, argv, status=ios)
if (ios == 0) then
  nullfile = trim(argv)
else
  call get_environment_variable('userprofile', status=ios)
  if (ios==0) then
    nullfile = 'NUL'
  else
    nullfile = '/dev/null'
  endif
endif

!---  BENCHMARK NUL -----------
! do NOT use status='old' as this can fail on various OS, compiler including PGI + Windows
open(newunit=u,file=nullfile,iostat=ios, action='write')
if (ios /= 0) then
  write(stderr,*) 'could not open NULL file: ' // nullfile
  error stop
endif

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

  writetime = real(tmin,wp) / rate
  close(u)

end function writetime

end program
