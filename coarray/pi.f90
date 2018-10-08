program coarray_pi
! implements calculation:
! $$ \pi = \int^1_{-1} \frac{dx}{\sqrt{1-x^2}} 

use, intrinsic:: iso_fortran_env, only: dp=>real64, int64, stderr=>error_unit
implicit none

integer, parameter :: wp = dp
real(wp), parameter :: x0 = -1.0_wp, x1 = 1.0_wp
real(wp), parameter :: pi = 4._wp*atan(1.0_wp)
real(wp) :: psum[*]  ! this is a scalar coarray
integer(int64) :: rate,tic,toc
real(wp) :: f,x,telaps, dx
integer :: i, stat, im, Ni
character(16) :: cbuf

psum = 0._wp

if (command_argument_count() > 0) then
  call get_command_argument(1, cbuf)
  read(cbuf,*, iostat=stat) dx
  if (stat/=0) error stop 'must input real number for resolution e.g. 1e-6'
else
  dx = 1e-6
endif
  
Ni = int((x1-x0) / dx)    ! (1 - (-1)) / interval
im = this_image()

!---------------------------------
if (im == 1) then
    call system_clock(tic)
    print '(A,I3)', 'number of Fortran coarray images:', num_images()
    print *,'approximating pi in ',Ni,' steps.'
end if
!---------------------------------

do i = im, Ni-1, num_images() ! Each image works on a subset of the problem
    x = x0 + i*dx
    f = dx / sqrt(1.0_wp - x**2)
    psum = psum + f
!    print *,x,f,psum
end do

! --- co_sum is much simpler, but not included even in ifort 2019 
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
    print '(A,E9.3,A,I3,A)', 'Elapsed wall clock time ', telaps, ' seconds, using',num_images(),' images.'
end if

end program

