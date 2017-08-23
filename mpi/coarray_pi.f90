program coarray_pi
!  Future: this example not yet working.
!  Michael Hirsch, Ph.D.
! example from: http://www.eneagrid.enea.it/tutorial/fanfarillo2014/AFanfarillo_20141219_CoarrayENEA.pdf

! Compilation:
! gfortran -fcoarray=lib coarray_helloworld.f90 -lcaf_mpi
!
! gfortran prereqs:  Ubuntu 17.04 / Debian Stretch 9 or newer:
! apt install libcoarrays-dev
!
! or use Intel 
! ifort -coarray coarray_pi.f90

use, intrinsic:: iso_fortran_env, only: wp=>real64, dp=>real64, int64
implicit none


integer(int64) :: rate,tic,toc
real(dp) :: telaps

real(wp), parameter :: interval=0.01_wp ! arbitrary
real(wp), codimension[*] ::psum
real(wp) :: dx ,x
real(wp) :: f, pi
integer :: i

!---------------------------------
if (this_image() == 1) then
    call system_clock(tic)
    print *, 'number of Fortran coarray images:', num_images()
end if
!---------------------------------
dx = 1.0_wp / interval

do i= 0, 10 ! arbitrary limits
    x = dx * (i - 0.5_wp)
    f = 4.0_wp / (1.0_wp + x**2)
    psum = psum + f
end do
call co_sum(psum)
pi = dx * psum

if (this_image() == 1)  print *,'pi ', pi

if ( this_image() == 1 ) then
    call system_clock(toc)
    call system_clock(count_rate=rate)
    telaps = (toc - tic) * 1000.0_dp/rate
    print '(A,ES10.3,A)', 'Elapsed wall clock time', telaps, ' seconds.'
end if

end program

