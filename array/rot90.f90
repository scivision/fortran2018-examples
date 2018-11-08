module rotflip

! This module provides rot90, flipud, fliplr for Fortran like Matlab and NumPy
! 
use, intrinsic:: iso_fortran_env, only: error_unit
implicit none

interface rot90
  module procedure rot90_i, rot90_r
end interface rot90

interface flip
  module procedure flip_i, flip_r
end interface flip

interface flipud
  module procedure flipud_i, flipud_r
end interface flipud

interface fliplr
  module procedure fliplr_i, fliplr_r
end interface fliplr

contains

integer function rot90_i(A, k) result(rot)
! https://github.com/numpy/numpy/blob/v1.14.2/numpy/lib/function_base.py#L54-L138

integer, intent(in) :: A(:,:)
integer, intent(in), optional :: k
dimension :: rot(size(A,1), size(A,2))
integer :: r

r = 1
if (present(k)) r = k

select case (modulo(r,4))
  case (0)
    rot = A  ! unmodified
  case (1) 
    rot = transpose(flip(A,1))
  case (2)
    rot = flip(A,0)
  case (3)
    rot = flip(transpose(A), 1)
end select

end function rot90_i


real function rot90_r(A, k) result(rot)
! https://github.com/numpy/numpy/blob/v1.14.2/numpy/lib/function_base.py#L54-L138

real, intent(in) :: A(:,:)
integer, intent(in), optional :: k
dimension :: rot(size(A,1), size(A,2))
integer :: r

r = 1
if (present(k)) r = k

select case (modulo(r,4))
  case (0)
    rot= A  ! unmodified
  case (1) 
    rot = transpose(flip(A,1))
  case (2)
    rot = flip(A,0)
  case (3)
    rot = flip(transpose(A), 1)
end select

end function rot90_r

!------------------------------

integer function flip_i(A, d) result(flip)

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

end function flip_i


real function flip_r(A, d)  result(flip)

real, intent(in) :: A(:,:)
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

end function flip_r


!------------------


integer function flipud_i(A) result(flipud)

integer, intent(in) :: A(:,:)
dimension :: flipud(size(A,1), size(A,2))

flipud = flip(A,1)

end function flipud_i


real function flipud_r(A) result(flipud)

real, intent(in) :: A(:,:)
dimension :: flipud(size(A,1), size(A,2))

flipud = flip(A,1)

end function flipud_r


!-----------------------------------------

integer function fliplr_i(A) result(fliplr)

integer, intent(in) :: A(:,:)
dimension :: fliplr(size(A,1), size(A,2))

fliplr = flip(A,2)

end function fliplr_i


real function fliplr_r(A) result(fliplr)

real, intent(in) :: A(:,:)
dimension :: fliplr(size(A,1), size(A,2))

fliplr = flip(A,2)

end function fliplr_r

end module rotflip
