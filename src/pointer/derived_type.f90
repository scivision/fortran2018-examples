module stuff

implicit none


type, abstract :: L1

integer, pointer :: bullseye(:,:)

end type L1


type, extends(L1) :: L2

integer, pointer :: arrow(:)

end type L2


class(L2), allocatable :: obj

end module stuff


program derived_type
!! https://software.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/a-to-z-reference/o-to-p/pointer-fortran.html

use stuff, only : L2,obj
implicit none

type :: A

integer, pointer :: arrow(:)
integer, allocatable :: bullseye(:,:)

end type A


type :: B

integer, pointer :: arrow(:)
integer, pointer :: bullseye(:,:)

end type B


type(A), target :: t1
type(B) :: t2

allocate(L2::obj)

nullify(t1%arrow)
nullify(t2%arrow)

if(associated(t1%arrow)) error stop "null pointers are not associated before use"
if(associated(t2%arrow)) error stop "null pointers are not associated before use"

allocate(t1%arrow(1:8))
allocate(t2%arrow(1:8))
allocate(obj%arrow(1:8))
t1%arrow = 5
t2%arrow = 5
obj%arrow = 5
if (any(t1%arrow /= [5,5,5,5,5,5,5,5])) stop "arrow is not allocated"
if (any(t2%arrow /= [5,5,5,5,5,5,5,5])) stop "arrow is not allocated"
if (any(obj%arrow /= [5,5,5,5,5,5,5,5])) stop "arrow is not allocated"

if(.not.associated(t1%arrow)) error stop "null pointers are associated after allocation"
if(.not.associated(t2%arrow)) error stop "null pointers are associated after allocation"
if(.not.associated(obj%arrow)) error stop "null pointers are associated after allocation"

allocate(t1%bullseye(1:8, 3))
allocate(t2%bullseye(1:8, 3))
allocate(obj%bullseye(1:8, 3))
t1%bullseye = 1
t2%bullseye = 1
obj%bullseye = 1
t1%bullseye(1:8:2, 2) = 10
t2%bullseye(1:8:2, 2) = 10
obj%bullseye(1:8:2, 2) = 10

!! reassociate pointer arrow
t1%arrow => t1%bullseye(2:7, 2)
t2%arrow => t2%bullseye(2:7, 2)
obj%arrow => obj%bullseye(2:7, 2)
if(size(t1%arrow) /= 6) error stop "size of arrow is not 6"
if(size(t2%arrow) /= 6) error stop "size of arrow is not 6"
if(size(obj%arrow) /= 6) error stop "size of arrow is not 6"
if(any(t1%arrow /= [1,10,1,10,1,10])) error stop "pointer arrow is not reassociated"
if(any(t2%arrow /= [1,10,1,10,1,10])) error stop "pointer arrow is not reassociated"
if(any(obj%arrow /= [1,10,1,10,1,10])) error stop "pointer arrow is not reassociated"

print *, "OK: pointer"

end program
