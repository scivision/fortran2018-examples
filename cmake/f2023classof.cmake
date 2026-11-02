block()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine work(a)
class(*), intent(in) :: a
classof(a), allocatable :: b
end subroutine"
f2023classof
)

endblock()
