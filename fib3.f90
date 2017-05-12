program runfib

    use iso_c_binding, only: dp=>C_DOUBLE
    implicit none

    integer, parameter :: N=1500
    real(dp) :: A(N)

    call fib(A)
    
    print *,A

contains

    Pure Subroutine FIB(A)
    !     CALCULATE FIRST N FIBONACCI NUMBERS

          REAL(dp), Intent(out) :: A(:)

          integer i,n
          n = size(A)

    A(1:2) = [0., 1.]

    DO I=3,N
        A(I) = A(I-1) + A(I-2)
    ENDDO

    END Subroutine Fib

end program runfib
