module contig

use, intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, i64=>int64

implicit none

contains

subroutine timestwo_contig(x, contig)
real(dp), contiguous, intent(inout) :: x(:,:)
logical, intent(out) :: contig

#if ISCONTIG
contig = is_contiguous(x)
#endif

x = 2*x
end subroutine timestwo_contig

subroutine timestwo(x, contig)
real(dp), intent(inout) :: x(:,:)
logical, intent(out) :: contig

#if ISCONTIG
contig = is_contiguous(x)
#endif

x = 2*x
end subroutine timestwo

end module contig



program c
use, intrinsic:: iso_fortran_env, only: compiler_version
use contig

implicit none

integer, parameter :: N = 1000000

real(dp) :: x(2,N) = 1.
integer(i64) :: tic, toc, rate
real(dp) :: t1, t2
logical :: iscontig1, iscontig2
!print *,compiler_version()  ! bug in flang 6 and PGI 18.10

call system_clock(tic)
call timestwo(x(:,1:N:2), iscontig1)
call system_clock(toc, rate)
t1 = (toc-tic) / real(rate, dp)

call system_clock(tic)
call timestwo_contig(x(:,1:N:2), iscontig2)
call system_clock(toc, rate)
t2 = (toc-tic) / real(rate, dp)

#if ISCONTIG
print *, iscontig1,' contig: ',t1,' sec.'
print *, iscontig2,' contig: ',t2,' sec.'
#else
print *, 'non-contig: ',t1,' sec.'
print *, 'contig: ',t2,' sec.'
#endif
end program
