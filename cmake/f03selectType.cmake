block()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine selector(x)

class(*), intent(in) :: x

select type (x)
  type is (real)
    print '(a)', 'real'
  type is (integer)
    print '(a)', 'integer'
end select

end subroutine"
f03selectType
)

endblock()
