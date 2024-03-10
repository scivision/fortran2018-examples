check_source_compiles(Fortran
"
program selectType
implicit none
real :: r
integer :: i

call selector(r)
call selector(i)

contains

subroutine selector(x)

class(*), intent(in) :: x

select type (x)
  type is (real)
    print *, 'real'
  type is (integer)
    print *, 'integer'
end select

end subroutine

end program
"
f03selectType
)
