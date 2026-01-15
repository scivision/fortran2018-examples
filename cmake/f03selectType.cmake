block()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine selector(x)
use, intrinsic :: iso_fortran_env

class(*), intent(in) :: x

select type (x)
  type is (real(real32))
    print '(a)', 'real32'
  type is (real(real64))
    print '(a)', 'real64'
  type is (integer(int32))
    print '(a)', 'int32'
  class default
    print '(a)', 'unknown type'
end select

end subroutine"
f03selectType
)

endblock()
