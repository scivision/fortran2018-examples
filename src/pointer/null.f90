program null_ptr
!! https://software.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/a-to-z-reference/o-to-p/pointer-fortran.html

implicit none

integer, POINTER :: arrow(:)
integer, ALLOCATABLE, TARGET :: bullseye(:,:)

nullify(arrow)

if(associated(arrow)) error stop "null pointers are not associated before use"

allocate(arrow(1:8))
arrow = 5
if (any(arrow /= [5,5,5,5,5,5,5,5])) stop "arrow is not allocated"

if(.not.associated(arrow)) error stop "null pointers are associated after allocation"

allocate(bullseye(1:8, 3))
bullseye = 1
bullseye(1:8:2, 2) = 10

!! reassociate pointer arrow
arrow => bullseye(2:7, 2)
if(size(arrow) /= 6) error stop "size of arrow is not 6"
if(any(arrow /= [1,10,1,10,1,10])) error stop "pointer arrow is not reassociated"

print *, "OK: pointer"

end program
