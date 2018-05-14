program helloworld
!  Each process prints out a "Hello, world!" message with a process ID.
! at least int64 is used with system_clock to ensure adequate resolution < 1 ms.
!  Michael Hirsch, Ph.D.

! Compilation:
! gfortran -fcoarray=lib helloworld.f90 -lcaf_mpi
!
! or use Intel ifort:
! ifort -coarray helloworld.f90

use, intrinsic:: iso_fortran_env, only: int64, dp=>real64
implicit none

integer(int64) :: rate,tic=0,toc
real(dp) :: telaps

! Print a message.
if (this_image() == 1) then
  call system_clock(tic)
  print *, 'number of Fortran coarray images:', num_images()
end if

sync all ! semaphore, ensures message above is printed at top.

print *, 'Process ', this_image()

sync all ! semaphore, ensures all have printed before toc
if (this_image() == 1) then
  call system_clock(count=toc, count_rate=rate)
  telaps = (toc - tic) / real(rate, dp)
  print *, 'Elapsed wall clock time', telaps, ' seconds.'
end if

end program

