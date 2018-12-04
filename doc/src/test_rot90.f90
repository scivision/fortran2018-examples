program rot90_array
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

call printarr(rot90(iarr,0),'rot90(0)')

call printarr(rot90(iarr,1), 'rot90(1)')

call printarr(rot90(iarr,2),'rot90(2)')

call printarr(rot90(iarr,3),'rot90(3)')

call printarr(flipud(iarr), 'flipud()')

call printarr(fliplr(iarr), 'fliplr()')

! -- test non-default bounds
Barr = iarr
print *,lbound(Barr,1)
Barr = rot90(Barr)
print *,lbound(Barr,1)

! -- Fortran polymorphic type
rarr = iarr
rarr = rot90(rarr)

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
