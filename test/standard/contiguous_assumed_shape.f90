program contiguous_assumed_shape

use, intrinsic:: iso_fortran_env, only: int64, real64

!! The ::2 indexing is not contiguous,
!! but the contiguous parameter in timestwo_contig COPIES the array into a contiguous temporary array,
!! which could be faster for some operations

implicit none

integer, parameter :: N = 1000000

real, allocatable :: x(:,:)
integer(int64) :: tic, toc, rate
real(real64) :: t1, t2

allocate(x(2,N))

x = 1.

call system_clock(tic)
call timestwo(x(:, ::2))
call system_clock(toc, rate)
t1 = (toc-tic) / real(rate, real64) * 1000

call system_clock(tic)
call timestwo_contig(x(:, ::2))
call system_clock(toc, rate)
t2 = (toc-tic) / real(rate, real64) * 1000

print '(a,i0)', "Benchmark time (milliseconds) for N = ", N
print '(A,F7.3)', 'non-contiguous:                   ',t1
print '(A,F7.3)', 'copy-in, copy-out is_contiguous:  ',t2

contains

pure subroutine timestwo_contig(x)
real, contiguous, intent(inout) :: x(:,:)

if (.not.is_contiguous(x)) error stop "should be contiguous per Fortran 2008 standard"

x = 2*x
end subroutine


pure subroutine timestwo(x)
real, intent(inout) :: x(:,:)

if(is_contiguous(x)) error stop "should not be contiguous"

x = 2*x
end subroutine

end program
