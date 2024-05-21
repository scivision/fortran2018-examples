program auto_allocate
!! demonstrate Fortran 2003 automatic allocation of arrays
!!
!! NOTE: even if an array allocate(), Fortran 2003 still allows auto-reallocation bigger or smaller
!! The A(:) syntax preserves previously allocated LHS shape, truncating RHS

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit, compiler_options, compiler_version
implicit none

real, allocatable, dimension(:) :: A, B, C, D, E
real :: C3(3)

print *, compiler_version()
print *, compiler_options()

!> Initial auto-allocate
A = [1,2,3]
B = [4,5,6]

C3 = A + B
C = A + B
if (any(C3 /= C)) error stop 'initial auto-allocate'
if (size(C) /= 3) error stop 'initial auto-alloc size'
print *, "OK: initial auto-allocate"

!> allocate bigger
A = [1,2,3,4]
B = [5,6,7,8]
C = A + B
if (any(C /= [6,8,10,12])) error stop 'auto-alloc bigger'
if (size(C) /= 4) error stop 'auto-alloc bigger size'
print *, "OK: auto-allocate bigger"

!> allocate smaller
A = [1,2]
B = [3,4]
C = A + B
if (any(C /= [4,6])) error stop 'auto-alloc smaller'
if (size(C) /= 2) error stop 'auto-alloc smaller size'
print *, "OK: auto-allocate smaller"

!> fixed allocate first
allocate(D(3), E(3))
D = [1,2]
E = [3,4,5,7]

if (size(D) /= 2) error stop 'allocate() auto-allocate small'
if (size(E) /= 4) error stop 'allocate() auto-allocate big'
print *, "OK: auto-allocate fixed allocate first"

!> if lhs(:) = rhs and shape(lhs) /= shape(rhs) behavior is UNDEFINED.
!> oneAPI 2023.0 newly detect with -CB -check bounds option.
A(:) = [9,8]
if (size(A) /= 2) error stop '(:) syntax smaller'
if (any(A /= [9,8])) then
  write(stderr,*) 'allocate() (:) assign small: A=', A
  error stop
endif
print *, "OK: auto-allocate (:) syntax smaller"

!> new for Gfortran 14
!! Fortran runtime error: Array bound mismatch for dimension 1 of array 'e' (4/3)
! E(:) = [1,2,3]
! if (size(E) /= 4) error stop 'allocate() (:) syntax small'
! if (any(E(:3) /= [1,2,3])) then
!   write(stderr,*) 'allocate() (:) assign small: E=', E(:3)
!   error stop
! endif
! print *, "OK: auto-allocate (:) syntax small"

!> new for Gfortran 14
!! Fortran runtime error: Array bound mismatch for dimension 1 of array 'e' (4/5)
! E(:) = [5,4,3,2,1]
! if (size(E) /= 5) error stop 'allocate() (:) syntax: big'
! if (any(E /= [5,4,3,2,1])) then
!   write(stderr,*) 'allocate() (:) assign: big: E=', E
!   error stop
! endif
! print *, "OK: auto-allocate (:) syntax big"

!> (lbound:ubound)
! A(1:3) = [4,5,6]
! gfortran -fcheck=bounds
! Fortran runtime error: Index '3' of dimension 1 of array 'a' outside of expected range (2:1)
! ifort -CB
! forrtl: severe (408): fort: (10): Subscript #1 of the array A has value 3 which is greater than the upper bound of 2
if (size(A) /= 2) error stop '(l:u) syntax smaller'

print *, 'OK: auto-allocate array'

end program
