program contiguous_pointer

implicit none

integer, pointer :: p(:)
integer, target :: t(6) = [1, 2, 3, 4, 5, 6]

p => t(::2)

call psub(p)
print *, "OK: contiguous_pointer"

contains

pure subroutine psub(a)
integer, contiguous, intent(in) :: a(:)

if(.not.is_contiguous(a)) error stop "a was not made contiguous as per Fortran standard"
if(any(a /= [1, 3, 5])) error stop "pointer stride incorrect"

end subroutine

end program
