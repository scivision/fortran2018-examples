program auto_allocate
!! demonstrate Fortran 2003 automatic allocation of arrays
!!
!! NOTE: if an array is manually allocated, Fortran 2003 allows auto-reallocation bigger or smaller

implicit none (type, external)

real, allocatable, dimension(:) :: A, B, C, D, E
real :: C3(3)

!> Initial auto-allocate
A = [1,2,3]
B = [4,5,6]

C3 = A + B
C = A + B
if (any(C3 /= C)) error stop 'initial auto-allocate'
if (size(C) /= 3) error stop 'initial auto-alloc size'

!> allocate bigger
A = [1,2,3,4]
B = [5,6,7,8]
C = A + B
if (any(C /= [6,8,10,12])) error stop 'auto-alloc smaller'
if (size(C) /= 4) error stop 'auto-alloc bigger size'

!> allocate smaller
A = [1,2]
B = [3,4]
C = A + B
if (any(C /= [4,6])) error stop 'auto-alloc smaller'
if (size(C) /= 2) error stop 'auto-alloc smaller size'

!> fixed allocate first
allocate(D(3), E(3))
D = [1,2]
E = [3,4,5,7]

if (size(D) /= 2) error stop 'auto-allocate smaller'
if (size(E) /= 4) error stop 'auto-allocate bigger'

print *, 'OK: auto-allocate array'

end program
