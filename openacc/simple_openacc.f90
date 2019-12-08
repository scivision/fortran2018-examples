!! simple OpenACC example
!!
!! * "a"  input to the accelerator
!! * "b"  output result from accelerator
program simple
implicit none

character(6) :: argv
integer :: i, N = 1000
real, allocatable :: a(:), b(:)

call get_command_argument(1, argv, status=i)
if (i==0) read(argv, *) N

allocate(a(n),b(n))

!$acc data copy(a,b)
call process(a, b, N)
!$acc end data

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