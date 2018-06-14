module rotflip

! This module provides rot90, flipud, fliplr for Fortran like Matlab and NumPy
! 
use, intrinsic:: iso_fortran_env, only: error_unit
implicit none

contains


integer function rot90(A, k)
! https://github.com/numpy/numpy/blob/v1.14.2/numpy/lib/function_base.py#L54-L138

integer, intent(in) :: A(:,:)
integer, intent(in), optional :: k
dimension :: rot90(size(A,1), size(A,2))
integer :: r

r = 1
if (present(k)) r = k

select case (modulo(r,4))
  case (0)
    rot90 = A  ! unmodified
  case (1) 
    rot90 = transpose(flip(A,1))
  case (2)
    rot90 = flip(A,0)
  case (3)
    rot90 = flip(transpose(A), 1)
end select

end function rot90


integer function flip(A, d)

integer, intent(in) :: A(:,:)
integer, intent(in) :: d
integer :: M, N
dimension :: flip(size(A,1), size(A,2))

M = size(A,1)
N = size(A,2)

select case (d)
  case (0)  ! flip both dimensions
    flip = A(M:1:-1, N:1:-1)
  case (1)
    flip = A(M:1:-1, :)
  case (2)
    flip = A(:, N:1:-1)
  case default
    error stop 'bad flip dimension, 2-D only  (1 or 2), or 0 for both dimensions'
end select

end function flip


integer function flipud(A)

integer, intent(in) :: A(:,:)
dimension :: flipud(size(A,1), size(A,2))

flipud = flip(A,1)

end function flipud


integer function fliplr(A)

integer, intent(in) :: A(:,:)
dimension :: fliplr(size(A,1), size(A,2))

fliplr = flip(A,2)

end function fliplr

end module rotflip
