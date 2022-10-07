module contig

use, intrinsic:: iso_fortran_env, only: int64, real64

implicit none

contains

pure subroutine timestwo_contig(x, contig)
real, contiguous, intent(inout) :: x(:,:)
logical, intent(out) :: contig

contig = is_contiguous(x)

x = 2*x
end subroutine timestwo_contig


pure subroutine timestwo(x, contig)
real, intent(inout) :: x(:,:)
logical, intent(out), optional :: contig

contig = is_contiguous(x)

x = 2*x
end subroutine timestwo

end module contig


program test_contigous
!! The ::2 indexing is not contiguous,
!! but the contiguous parameter in timestwo_contig COPIES the array into a contiguous temporary array,
!! which could be faster for some operations
use contig

implicit none

integer, parameter :: N = 1000000

real, allocatable :: x(:,:)
integer(int64) :: tic, toc, rate
real(real64) :: t1, t2
logical :: iscontig1, iscontig2

allocate(x(2,N))

x = 1.

call system_clock(tic)
call timestwo(x(:, ::2), iscontig1)
call system_clock(toc, rate)
t1 = (toc-tic) / real(rate, real64)

call system_clock(tic)
call timestwo_contig(x(:, ::2), iscontig2)
call system_clock(toc, rate)
t2 = (toc-tic) / real(rate, real64)
if (.not.iscontig2) error stop 'contiguous array not contiguous'

print '(L2,A,F7.3,A)', iscontig1,' contig: ',t1,' sec.'
print '(L2,A,F7.3,A)', iscontig2,' contig: ',t2,' sec.'

end program
