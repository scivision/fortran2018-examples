program helloworld
!  Each process prints out a "Hello, world!" message with a process ID
!  Michael Hirsch, Ph.D.

! Compilation:
! gfortran -fcoarray=lib coarray_helloworld.f90 -lcaf_mpi
!
! or use Intel ifort:
! ifort -coarray coarray_helloworld.f90

use, intrinsic:: iso_fortran_env, only: dp=>real64, int64
implicit none

integer(int64) :: rate,tic,toc
real(dp) :: telaps

! Print a message.
if (this_image() == 1) then
    call system_clock(tic)
    print *, 'number of Fortran coarray images:', num_images()
end if

print *, 'Process ', this_image()

sync all  ! semaphore

if ( this_image() == 1 ) then
    call system_clock(toc)
    call system_clock(count_rate=rate)
    telaps = (toc - tic) * 1000.0_dp/rate
    print '(A,ES10.3,A)', 'Elapsed wall clock time', telaps, ' seconds.'
end if

end program

