module newton

use, intrinsic :: iso_fortran_env, only: wp => real64, stderr => error_unit

implicit none

private
public :: wp, newtopts, newton_exact, objfun, objfun_deriv

!> derived type for containing the options for the newton method procedure, by default
!   these work okay with the dipole to spherical conversion problem but can be adjusted
!   by the user for other applications
type :: newtopts
  real(wp) :: derivtol=1e-18
  integer :: maxit=100
  real(wp) :: tol=1e-9
  logical :: verbose=.false.
end type newtopts

!> these interfaced define the types of functions needed to run Newton iterations
!   need to match custom functions defined in using modules; these are defined so
!   that there are multiple objective functions (conforming to these patterns) that
!   can be used with Newton's method.  These are abstract because there are multiple
!   objective functions (in principle) that can be used with Newton's method
abstract interface
  real(wp) function objfun(x,parms)
    import wp
    real(wp), intent(in) :: x
    real(wp), dimension(:), intent(in) :: parms
  end function

  real(wp) function objfun_deriv(x,parms)
    import wp
    real(wp), intent(in) :: x
    real(wp), dimension(:), intent(in) :: parms
  end function
end interface

contains

!> this implmements the exact Newton method for solving a nonlinear equation
subroutine newton_exact(f,fprime,x0,parms,newtparms,root,it,converged)
procedure(objfun), pointer, intent(in) :: f
procedure(objfun_deriv), pointer, intent(in) :: fprime
real(wp), intent(in) :: x0                      ! starting point for newton iteration
real(wp),dimension(:), intent(in) :: parms      ! fixed parameters of the newton iteration, f,fprime must accommodate whatever size array is passed in
type(newtopts), intent(in) :: newtparms         ! options for the iteration that can be set by the user
real(wp), intent(out) :: root
integer, intent(out) :: it
logical, intent(out) :: converged

real(wp) :: fval,derivative

! check starting point is not too close to inflection
if (abs(fprime(x0,parms))<newtparms%derivtol) then
write(stderr,*) 'Warning:  starting near inflection point, please change initial guess!'
it=0; converged=.false.; root=x0;
return
end if

! Newton iteration main loop
it=1; root=x0; fval=f(root,parms); converged=.false.
do while (.not. converged .and. it <= newtparms%maxit)
derivative=fprime(root,parms)
if (abs(derivative)<newtparms%derivtol) then
    write(stderr,*) 'Warning:  Encountered inflection point during iteration:  ',it
    return
else
    root=root-fval/derivative
    fval=f(root,parms)
    if (newtparms%verbose) then
    print*, ' Iteration ',it,'; root ',root,' fval ',fval,' derivative ',derivative
    end if
    it=it+1
    converged=abs(fval)<newtparms%tol
end if
end do
it=it-1

end subroutine newton_exact

end module newton


program main

use newton, only: wp, newtopts, objfun, objfun_deriv, newton_exact

implicit none

real(wp) :: q,p,r

real(wp), parameter :: Re=6371e3_wp ! Earth radius in meters

type(newtopts) :: newtparms
real(wp), dimension(2) :: parms
real(wp) :: r0
procedure(objfun), pointer :: f
procedure(objfun_deriv), pointer :: fprime
integer :: maxrestart, maxr, r0step
integer :: it,ir0
logical :: converged

! Set parameters of the restart and Newton iterations
maxrestart=400
maxr=100*Re
r0step=0.25*Re
newtparms%maxit=100
newtparms%derivtol=1e-18
newtparms%tol=1e-11
newtparms%verbose=.false.
f=>rpoly
fprime=>rpoly_deriv
parms=[q,p]

! Newton iterations with restarting (see parameters above for limits) until we get a satisfactory result
r=0; converged=.false.; ir0=1;
do while (.not. converged .and. ir0<maxrestart .and. (r<=0 .or. r>maxr))
    r0=(ir0-1)*(r0step)    ! change starting point in increments of 0.25 Re until we get a "good" answer
    call newton_exact(f,fprime,r0,parms,newtparms,r,it,converged)
    ir0=ir0+1
end do

print '(a,2f20.10)', ' r, Re = ', r, Re
print '(a,i0)', ' iterations = ', it
print '(a,l1)', ' converged = ', converged

contains
  !> objective function for newton iterations for solutions of roots for r
  function rpoly(x,parms) result(fval)
      real(wp), intent(in) :: x
      real(wp), dimension(:), intent(in) :: parms
      real(wp) :: fval

    real(wp) ::  q,p

    q=parms(1); p=parms(2);
    fval=q**2*(x/Re)**4 + 1/p*(x/Re) - 1
  end function rpoly


  !> derivative objective function for newton iterations for roots of r
  function rpoly_deriv(x,parms) result(fval_deriv)
    real(wp), intent(in) :: x
    real(wp), dimension(:), intent(in) :: parms
    real(wp) :: fval_deriv

    real(wp) :: q,p

    q=parms(1); p=parms(2);
    fval_deriv=4/Re*q**2*(x/Re)**3 + 1/p/Re
  end function rpoly_deriv


end program
