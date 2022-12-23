program test_rot90
! demo rotating a 2-D array 90 degrees clockwise
use rotflip, only: rot90, flipud, fliplr

implicit none

integer, parameter :: N=3
integer :: i, iarr(N,N),  Barr(0:2, 0:2)
real :: rarr(N,N)

iarr = reshape( &
  [0, 1, 2, &
   3, 4, 5, &
   6, 7, 8], &
   shape(iarr), order=[2,1])

rarr = iarr


call printarr(iarr,'before rot90')

call rot90(iarr, 0)
call printarr(iarr, 'rot90(0)')

call rot90(iarr, 1)
call printarr(iarr, 'rot90(1)')
call rot90(iarr, -1)

call rot90(iarr, 2)
call printarr(iarr, 'rot90(2)')
call rot90(iarr, -2)

call rot90(iarr, 3)
call printarr(iarr, 'rot90(3)')
call rot90(iarr, -3)

call flipud(iarr)
call printarr(iarr, 'flipud()')
call flipud(iarr)

call fliplr(iarr)
call printarr(iarr, 'fliplr()')
call fliplr(iarr)

! -- test non-default bounds
Barr = iarr
if (lbound(Barr,1) /= 0) error stop 'lbound should be 0'

call rot90(Barr)
if (lbound(Barr,1) /= 0) error stop 'lbound should be 0'

! -- Fortran polymorphic type
rarr = iarr
call rot90(rarr)

contains


subroutine printarr(arr, msg)

integer, intent(in) :: arr(:,:)
character(*), intent(in), optional :: msg
character(5) :: frmt

write(frmt,'(A1,I1,A3)') '(',size(arr,1),'I1)'

if(present(msg)) print *,msg
do i = 1, size(arr,1)
  print frmt, arr(i,:)
enddo


end subroutine printarr
end program
