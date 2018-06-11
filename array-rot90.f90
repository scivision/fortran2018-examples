program rot90_array
! demo rotating a 2-D array 90 degrees clockwise
!
! briefly, rot90() in Fortran for 2-D array is:
!   rot90 = transpose(array(ubound(array,1):lbound(array,1):-1, :))
use, intrinsic:: iso_fortran_env, only: error_unit
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

rotArray = rot90(array,0)
print *,'rot90(0)'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo

rotArray = rot90(array,1)
print *,'rot90(1)'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo

rotArray = rot90(array,2)
print *,'rot90(2)'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo

rotArray = rot90(array,3)
print *,'rot90(3)'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo


rotArray = flipud(array)
print *,'flipud()'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo

rotArray = fliplr(array)
print *,'fliplr()'
do i = 1, size(array,1)
  print '(3I1)', rotArray(i,:)
enddo


contains


integer function rot90(array, k)
! https://github.com/numpy/numpy/blob/v1.14.2/numpy/lib/function_base.py#L54-L138

integer, intent(in) :: array(:,:)
integer, intent(in), optional :: k
dimension :: rot90(lbound(array,1):ubound(array,1), &
                   lbound(array,2):ubound(array,2))
integer :: r

r = 1
if (present(k)) r = k

select case (modulo(r,4))
  case (0)
    rot90 = array  ! unmodified
  case (1) 
    rot90 = transpose(flip(array,1))
  case (2)
    rot90 = flip(array,0)
  case (3)
    rot90 = flip(transpose(array), 1)
end select

end function rot90


integer function flip(array, d)

integer, intent(in) :: array(:,:)
integer, intent(in) :: d
dimension :: flip(lbound(array,1):ubound(array,1), &
                  lbound(array,2):ubound(array,2))

select case (d)
  case (0)  ! flip both dimensions
    flip = array(ubound(array,1):lbound(array,1):-1, &
                 ubound(array,1):lbound(array,1):-1)
  case (1)
    flip = array(ubound(array,1):lbound(array,1):-1, :)
  case (2)
    flip = array(:, ubound(array,1):lbound(array,1):-1)
  case default
    error stop 'bad flip dimension, 2-D only  (1 or 2), or 0 for both dimensions'
end select

end function flip


integer function flipud(array)

integer, intent(in) :: array(:,:)
dimension :: flipud(lbound(array,1):ubound(array,1), &
                    lbound(array,2):ubound(array,2))

flipud = flip(array,1)

end function flipud


integer function fliplr(array)

integer, intent(in) :: array(:,:)
dimension :: fliplr(lbound(array,1):ubound(array,1), &
                    lbound(array,2):ubound(array,2))

fliplr = flip(array,2)

end function fliplr

end program
