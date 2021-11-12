!! minloc and maxloc with all false mask= can have surprising,
!! compiler and compiler flag dependent behavior.
!!
!! Unfortunately, the Fortran 90 standard notes "processor dependent behavior"
!! in 13.13.[65,70]. This is in contrast to index() in 13.13.46, which specifies
!! 0 as the result for a similar outcome.
!! This means users should shield maxloc/minloc when the mask= argument is used.
!!
!! GCC: https://gcc.gnu.org/onlinedocs/gfortran/MAXLOC.html
!! Gfortran result 0 if mask==.false.
!!
!! Intel oneAPI: https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/a-to-z-reference/m-to-n/minloc.html
!! ifort/ifx result 1 if mask==.false.

program minloc_maxloc_mask

implicit none (type, external)

real :: A(5) = [0, 5, 1, 2, 3]
integer :: L

logical :: mask(size(A))


if(maxloc(A, dim=1) /= 2) error stop "maxloc sanity"
if(minloc(A, dim=1) /= 1) error stop "minloc sanity"

if(maxloc(A, dim=1, mask=[.true., .false., .true., .true., .true.]) /= 5) error stop "maxloc mask sanity"
if(minloc(A, dim=1, mask=[.false., .true., .true., .true., .true.]) /= 3) error stop "minloc mask sanity"

!> compiler and compiler flag dependent behavior
!! our testing showed:
!! GCC: 0
!! ifort/ifx: 1 -assume old_maxminloc (default)
!! ifort/ifx: 0 -assume noold_maxminloc
mask = .false.
print *, "maxloc mask = .false.", maxloc(A, dim=1, mask=mask)
print *, "minloc mask = .false.", minloc(A, dim=1, mask=mask)

print *, "OK: minloc_maxloc_mask"

end program
