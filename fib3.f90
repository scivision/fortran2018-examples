Subroutine FIB(A,N)
implicit none
!     CALCULATE FIRST N FIBONACCI NUMBERS
      INTEGER, Intent(in) :: N
      REAL*8, Intent(out) :: A(N)

      integer i

A(1:2) = [0., 1.]

DO I=3,N
    A(I) = A(I-1) + A(I-2)
ENDDO

END Subroutine
