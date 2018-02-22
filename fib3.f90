module fib3
! https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fC_005fBINDING.html
    use, intrinsic :: iso_c_binding, only: real32=>C_FLOAT, real64=>C_DOUBLE!, qp=c_long_double

    implicit none
    
    include 'kind.txt'

    real(real32),parameter :: pi32 = 4._real32*atan(1._real32)
    real(real64),parameter :: pi64 = 4._real64*atan(1._real64)
    !real(qp),parameter :: pi128 = 4._qp*atan(1._qp)
    

contains

    pure function FIB(n)

    !     CALCULATE FIRST N FIBONACCI NUMBERS
    integer, intent(in) :: n
    real(wp), dimension(n) :: fib(n)

    integer i

    fib(:2) = [0, 1]

    do I=3,N
        fib(I) = fib(I-1) + fib(I-2)
    enddo

    end function Fib

end module
