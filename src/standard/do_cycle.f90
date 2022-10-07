program nested_cycler

implicit none

integer :: i,j,k,c
integer :: R(18,3) !>if not for cycle, it would be R(27,3)

R = reshape(&
[1, 1, 1,&
1, 1, 2,&
1, 2, 1,&
1, 2, 2,&
1, 3, 1,&
1, 3, 2,&
2, 1, 1,&
2, 1, 2,&
2, 2, 1,&
2, 2, 2,&
2, 3, 1,&
2, 3, 2,&
3, 1, 1,&
3, 1, 2,&
3, 2, 1,&
3, 2, 2,&
3, 3, 1,&
3, 3, 2], shape=shape(R), order=[2,1])

c=1
x: do i = 1,3
  y: do j = 1,3
    z: do k = 1,3
      if (k>2) cycle y  !< also resets k==1
      if (any([i,j,k] /= R(c,:))) error stop c
      c = c+1
    enddo z
  enddo y
enddo x

end program

!> output
