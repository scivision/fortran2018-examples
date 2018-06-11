program rot90_array
! demo rotating a 2-D array 90 degrees clockwise
!
! briefly, rot90() in Fortran for 2-D array is:
!   rot90 = transpose(array(ubound(array,1):lbound(array,1):-1, :))

implicit none

integer, parameter :: N=3
integer :: i, array(N,N), rotArray(N,N)

array = reshape( &
  [0, 1, 2, &
   3, 4, 5, &
   6, 7, 8], &
   shape(array), order=[2,1])
   
print *,'before rot90'
do i = 1, size(array,1)
  print '(3I1)', array(i,:)
enddo

rotArray = rot90(array)

print *,'before rot90'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo

contains


integer function rot90(array)

integer, intent(in) :: array(:,:)
dimension :: rot90(size(array,1), size(array,2))



rot90 = transpose(array(ubound(array,1):lbound(array,1):-1, :))

end function rot90


end program
