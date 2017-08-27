program coarray_pi
!  Michael Hirsch, Ph.D.

! Compilation:
! gfortran -fcoarray=lib coarray_pi.f90 -lcaf_mpi
! mpirun -np 4 ./a.out
! Note that if you don't use mpirun for gfortran, only a single image will spawn.
! 
! test with single process
! gfortran -fcoarray=single coarray_pi.f90
! ./a.out
!
! gfortran prereqs:  Ubuntu 17.04 / Debian Stretch 9 or newer:
! apt install libcoarrays-dev
!
! or use Intel 
! ifort -coarray coarray_pi.f90
! ifort ./a.out will automatically spawn images = number of virtual cores, mpirun not needed as with gfortran.
!
! This demo program implements calculation:
! $$ \pi = \int^1_{-1} \frac{dx}{\sqrt{1-x^2}} 

use, intrinsic:: iso_fortran_env, only: wp=>real64, dp=>real64, int64, stderr=>error_unit
implicit none


integer(int64) :: rate,tic,toc
real(dp) :: telaps

real(wp), parameter :: dx = 0.000000001_wp ! arbitrary
real(wp), parameter :: x0 = -1.0_wp
real(wp), parameter :: x1 = 1.0_wp
integer, parameter :: Ni = int((x1-x0) / dx)    ! (1 - (-1)) / interval
real(wp), parameter :: pi = 4.0_wp*atan(1.0_wp)
real(wp) :: psum[*] = 0.0_wp ! this is a scalar coarray
real(wp) :: f,x
integer :: i, stat, im, Nimg
character :: emsg

im = this_image()
Nimg = num_images()

!---------------------------------
if (im == 1) then
    call system_clock(tic)
    print *, 'number of Fortran coarray images:', num_images()
    print *,'approximating pi in ',Ni,' steps.'
end if
!---------------------------------

do i = im, Ni-1, Nimg ! Each image works on a subset of the problem
    x = x0 + i*dx
    f = dx / sqrt(1.0_wp - x**2)
    psum = psum + f
!    print *,x,f,psum
end do

! ---- alternative to co_sum for Intel 2017 that doesn't have working co_sum (!!!)
!sync all
!if (im==1) then
 ! do i = 2, Nimg
!    psum = psum + psum[i]
 ! enddo 
!endif
! --- co_sum is much simpler, but not working on ifort 2017 yet
call co_sum(psum)!, stat=stat,errmsg=emsg)  
!if (stat /= 0) then
!   write (stderr,*) emsg
!   error stop
!endif

if (im == 1)  then
    print *,'pi:',pi,'  iterated pi: ',psum
    print '(A,E10.3)', 'pi error',pi - psum
endif

if (im == 1) then
    call system_clock(toc)
    call system_clock(count_rate=rate)
    telaps = real((toc - tic),wp)  / rate
    print '(A,F8.3,A)', 'Elapsed wall clock time', telaps, ' seconds.'
end if

end program

