module rotflip_rank
!! this demos assumed rank operations
!! generally this requires a compiler released in year 2020 or later including:
!!
!! * Gfortran >= 10
!! * Intel Fortran >= 20.0
implicit none (type, external)

contains

subroutine flipud(A)

integer, intent(inout) :: A(..)

select rank(A)
  rank (0)
    ! do nothing
  rank (1)
    A = A(ubound(A,1):lbound(A,1):-1)
  rank (2)
    A = A(ubound(A,1):lbound(A,1):-1, :)
  rank default
    error stop 'flipud: only rank 0..2 is handled for now.'
end select

end subroutine flipud


end module rotflip_rank


program assumed_rank

use rotflip_rank, only: flipud

implicit none (type, external)

integer :: i, A0 = 0, A1(3) = [0,1,2]
integer :: A2(3,3) = reshape( &
[0, 1, 2, &
 3, 4, 5, &
 6, 7, 8], &
 shape(A2), order=[2,1])
integer :: A3(3,3,3)

A3(:,:,1) = A2
A3(:,:,2) = A2+9
A3(:,:,3) = A2+18

call flipud(A0)

print '(A20,3I3)', '1D vector', A1
call flipud(A1)
print '(A20,3I3)', '1D vector reverse', A1

print *, '2D array'
do i = 1,size(A2,1)
  print '(3I3)', A2(i,:)
enddo
call flipud(A2)
print *, '2D array flipud'
do i = 1,size(A2,1)
  print '(3I3)', A2(i,:)
enddo

end program assumed_rank
