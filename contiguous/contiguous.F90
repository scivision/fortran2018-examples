module contig

use, intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, i64=>int64

implicit none (type, external)


contains

subroutine timestwo_contig(x, contig)
real(dp), contiguous, intent(inout) :: x(:,:)
logical, intent(out) :: contig

#ifdef ISCONTIG
contig = is_contiguous(x)
#endif

x = 2*x
end subroutine timestwo_contig


subroutine timestwo(x, contig)
real(dp), intent(inout) :: x(:,:)
logical, intent(out), optional :: contig

#ifdef ISCONTIG
contig = is_contiguous(x)
#endif

x = 2*x
end subroutine timestwo

end module contig


program test_contigous
!! The ::2 indexing is not contiguous,
!! but the contiguous parameter in timestwo_contig copies the array into contiguous temporary array,
!! which could be faster for some operations
use, intrinsic:: iso_fortran_env, only: compiler_version
use contig

implicit none (type, external)

integer, parameter :: N = 1000000

real(dp) :: x(2,N) = 1.
integer(i64) :: tic, toc, rate
real(dp) :: t1, t2
logical :: iscontig1, iscontig2
!print *,compiler_version()  ! bug in flang 6 and PGI 18.10

#ifdef ISCONTIG
call system_clock(tic)
call timestwo(x(:, ::2), iscontig1)
call system_clock(toc, rate)
t1 = (toc-tic) / real(rate, dp)

call system_clock(tic)
call timestwo_contig(x(:, ::2), iscontig2)
call system_clock(toc, rate)
t2 = (toc-tic) / real(rate, dp)

print '(L2,A,F7.3,A)', iscontig1,' contig: ',t1,' sec.'
print '(L2,A,F7.3,A)', iscontig2,' contig: ',t2,' sec.'
#else
call system_clock(tic)
call timestwo(x(:, ::2))
call system_clock(toc, rate)
t1 = (toc-tic) / real(rate, dp)

print '(A,F7.3,A)', 'non-contig: ',t1,' sec.'
#endif
end program
