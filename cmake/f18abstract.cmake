set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran
"module abstract_interface

abstract interface
  real function fun()
  end function fun
end interface

contains

subroutine canary(f)
  procedure(fun), pointer, intent(in) :: f
  real :: a

  a = f()
end subroutine canary

end module abstract_interface"
f18abstract
)
