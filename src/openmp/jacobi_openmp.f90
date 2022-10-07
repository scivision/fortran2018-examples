program jacobi_omp
!! https://nanohub.org/resources/19384/download/Directive_Based_Programming.pdf

use, intrinsic :: iso_fortran_env, only : int64
implicit none

integer(int64) :: tic, toc, trate
real :: err, tol
real, allocatable, dimension(:,:) :: A, Anew
integer :: i, j, m, n, iter, iter_max
real, parameter :: pi=4*atan(1.)

call system_clock(count_rate=trate)

m = 100
n = 200

tol = 0.01

iter_max = 1000  !< 1000: accurate to 4 digits
iter = 0
err = 1.

allocate(A(0:n+1,0:m+1), Anew(n,m))

call random_number(A)

call system_clock(tic)

do while ( err > tol .and. iter < iter_max )
  err = 0.

  !$omp parallel do shared(m,n,Anew,A) reduction(max:err)
  do j=1,m
    do i=1,n
      Anew(i,j) = 0.25 * (A(i+1, j)   + A(i-1, j) + &
                          A(i  , j-1) + A(i  , j+1))

      err = max(err, Anew(i, j) - A(i,j))
    end do
  end do

  !$omp parallel do shared(m,n,Anew,A)
  do j=1,m-2
    do i=1,n-2
      A(i,j) = Anew(i,j)
    end do
  end do

  iter = iter +1
  if (mod(iter, 100) == 0) print*,iter,err
end do

call system_clock(toc)

print *, real(toc-tic)*1000./ real(trate), iter

end program
