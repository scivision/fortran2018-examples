module rotflip

! This module provides rot90, flipud, fliplr for Fortran like Matlab and NumPy
! 
use, intrinsic:: iso_fortran_env, only: error_unit
implicit none

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

end module rotflip
