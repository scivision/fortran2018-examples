module rotflip

! This module provides rot90, flipud, fliplr for Fortran like Matlab and NumPy
!
! Note: PGI 19.10 still doesn't run this code correctly
! (compiles but falls through to class default)
!
use, intrinsic:: iso_fortran_env, only: error_unit

implicit none (type, external)

contains

subroutine rot90(A, k)
! https://github.com/numpy/numpy/blob/v1.14.2/numpy/lib/function_base.py#L54-L138

class(*), intent(inout) :: A(:,:)
integer, intent(in), optional :: k
integer :: r

r = 1
if (present(k)) r = k

select type (A)
  type is (integer)
    select case (modulo(r,4))
      case (0)  ! unmodified
      case (1)
        call flip(A,1)
        A = transpose(A)
      case (2)
        call flip(A,0)
      case (3)
        A = transpose(A)
        call flip(A, 1)
    end select
  type is (real)
    select case (modulo(r,4))
      case (0)  ! unmodified
      case (1)
        call flip(A,1)
        A = transpose(A)
      case (2)
        call flip(A,0)
      case (3)
        A = transpose(A)
        call flip(A, 1)
    end select
  class default
    error stop 'rot90: not real or integer'
end select

end subroutine rot90


subroutine flip(A, d)

class(*), intent(inout) :: A(:,:)
integer, intent(in) :: d
integer :: M, N

M = size(A,1)
N = size(A,2)

select type (A)
  type is (integer)
    select case (d)
      case (0)  ! flip both dimensions
        A = A(M:1:-1, N:1:-1)
      case (1)
        A = A(M:1:-1, :)
      case (2)
        A = A(:, N:1:-1)
      case default
        error stop 'bad flip dimension, 2-D only  (1 or 2), or 0 for both dimensions'
    end select
  type is (real)
    select case (d)
      case (0)  ! flip both dimensions
        A = A(M:1:-1, N:1:-1)
      case (1)
        A = A(M:1:-1, :)
      case (2)
        A = A(:, N:1:-1)
      case default
        error stop 'bad flip dimension, 2-D only  (1 or 2), or 0 for both dimensions'
    end select
  class default
    error stop 'flip: not real or integer'
end select

end subroutine flip


subroutine flipud(A)

class(*), intent(inout) :: A(:,:)

select type (A)
  type is (real)
    call flip(A,1)
  type is (integer)
    call flip(A,1)
  class default
    error stop 'flipud: not an integer or real'
end select

end subroutine flipud


subroutine fliplr(A)

class(*), intent(inout) :: A(:,:)

select type (A)
  type is (real)
    call flip(A,2)
  type is (integer)
    call flip(A,2)
  class default
    error stop 'fliplr: not an integer or real'
end select

end subroutine fliplr


end module rotflip
