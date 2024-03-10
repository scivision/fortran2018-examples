check_source_compiles(Fortran
"program a
implicit none
character(:), allocatable :: x(:)

character(:), allocatable :: flex(:), scalar

flex = [character(5) :: 'hi', 'hello']
end program"
f03charalloc
)
