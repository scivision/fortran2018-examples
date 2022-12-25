!! simple OpenACC example
!!
!! * "a"  input to the accelerator
!! * "b"  output result from accelerator
program simple
use, intrinsic :: iso_fortran_env, only : int64
implicit none

character(16) :: argv
integer :: i, N = 1000
integer(int64) :: tic, toc, trate
real, allocatable :: a(:), b(:)
real, parameter :: pi=4*atan(1.)

call system_clock(count_rate=trate)

call get_command_argument(1, argv, status=i)
if (i==0) read(argv, *) N

allocate(a(n),b(n))

do i=1,N
  a(i) = pi*i/N
enddo

call system_clock(tic)

!$acc data copy(a,b)
call process(a, b, N)
!$acc end data

call system_clock(toc)

print *, (toc-tic)*1000./trate, N

! print *,b

contains

subroutine process(a, b, N)

real, intent(in) :: a(:)
real, intent(out) :: b(:)
integer, intent(in) :: N
integer :: i

!$acc parallel loop
do i = 1, N
  b(i) = exp(sin(a(i)))
enddo

end subroutine process

end program
