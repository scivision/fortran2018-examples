block()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine test_typeof(a)

class(*), intent(in) :: a

class(classof(a)),  :: b

end subroutine"
f2023classof
)

endblock()
