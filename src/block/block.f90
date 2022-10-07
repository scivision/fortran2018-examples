program demo_block
!! Shows Fortran 2008 block namespace
!! At BLOCK exit, local allocatables are deallocated, but outer scope allocatable are NOT deallocated
!!
!! program output:
!! ./block
!! block scope j=          42
!!  block scope size(B)=           4
!!  outer scope i=          10
!!  A allocated T size(a)           4

implicit none

integer :: i, j
real, allocatable :: A(:)

i = 10
j = 42

flowers: block
  integer :: i
  real, allocatable :: B(:)
  i = 3
  print *, 'block scope j=',j  !< 42

  i = i + 1
  allocate(A(i), B(i))

  print *, 'block scope size(B)=',size(B) !< 4, deallocates on block exit (not visible in outer scope)

end block flowers

!> next line prints 10, as the outer scope `i` was not in scope of the block
print *, 'outer scope i=',i
print *, 'A allocated',allocated(A),'size(a)',size(A)

end program
