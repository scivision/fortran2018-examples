check_fortran_source_compiles(
"
program test
implicit none
contains

subroutine r(A)
integer, intent(inout) :: A(..)
select rank(A)
  rank default
    error stop
end select
end subroutine r
end program
"
f18assumed_rank
SRC_EXT f90
)
