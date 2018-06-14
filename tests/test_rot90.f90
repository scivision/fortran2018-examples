program rot90_array
! demo rotating a 2-D array 90 degrees clockwise
use rotflip, only: rot90, flipud, fliplr

implicit none

integer, parameter :: N=3
integer :: i, array(N,N), Barr(0:2, 0:2)

array = reshape( &
  [0, 1, 2, &
   3, 4, 5, &
   6, 7, 8], &
   shape(array), order=[2,1])
   
Barr = array
   
call printarr(array,'before rot90')

call printarr(rot90(array,0),'rot90(0)')

call printarr(rot90(array,1), 'rot90(1)')

call printarr(rot90(array,2),'rot90(2)')

call printarr(rot90(array,3),'rot90(3)')

call printarr(flipud(array), 'flipud()')

call printarr(fliplr(array), 'fliplr()')

! -- test non-default bounds
print *,lbound(Barr,1)
Barr = rot90(Barr)
print *,lbound(Barr,1)

contains


subroutine printarr(arr, msg)

integer, intent(in) :: arr(:,:)
character(*), intent(in), optional :: msg

if(present(msg)) print *,msg
do i = lbound(arr,1), ubound(arr,1)
  print '(3I1)', arr(i,:)
enddo


end subroutine printarr
end program
