module abstract_interface

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

end module abstract_interface

program dummy

end program dummy
