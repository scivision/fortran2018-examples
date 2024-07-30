set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine r()
character(:), allocatable :: flex(:), scalar

flex = [character(5) :: 'hi', 'hello']
end subroutine"
f03charalloc
)
