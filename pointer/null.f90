program null_ptr
!! https://software.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/a-to-z-reference/o-to-p/pointer-fortran.html

implicit none (type, external)

REAL, POINTER :: arrow(:)
REAL, ALLOCATABLE, TARGET :: bullseye(:,:)

if(associated(arrow)) error stop "null pointers are not associated before use"

allocate(arrow(1:8))
arrow = 5.
if (any(arrow /= [5,5,5,5,5,5,5,5])) stop "arrow is not allocated"

if(.not.associated(arrow)) error stop "null pointers are associated after allocation"

allocate(bullseye(1:8, 3))
bullseye = 1.
bullseye(1:8:2, 2) = 10.

!! reassociate pointer arrow
arrow => bullseye(2:7, 2)
if(any(abs(arrow - [1,10,1,10,1,10,1]) > 1e-5)) error stop "pointer arrow is not reassociated"

print *, "OK: pointer"

end program
