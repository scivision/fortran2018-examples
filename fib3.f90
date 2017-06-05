module fib3
! https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fC_005fBINDING.html
    use, intrinsic :: iso_c_binding, only: sp=>C_FLOAT, dp=>C_DOUBLE!, qp=c_long_double

    implicit none

    real(sp),parameter :: pi32 = 4.*atan(1.)
    real(dp),parameter :: pi64 = 4._dp*atan(1._dp)
    !real(qp),parameter :: pi128 = 4._qp*atan(1._qp)
    

contains

    pure subroutine FIB(A,n)

    !     CALCULATE FIRST N FIBONACCI NUMBERS
    integer, intent(in) :: n
    real(dp), Intent(out) :: A(n)

    integer i

    A(:2) = [0, 1]

    do I=3,N
        A(I) = A(I-1) + A(I-2)
    enddo

    end subroutine Fib

end module
