# Call Fortran from C++

Fortran subroutines and functions are easily called from C and C++.

The key factors in calling a Fortran module from C or C++ include:

* use the standard C binding to define variable and bind functions/subroutines
  ```fortran
  module flibs
  
  use,intrinsic:: iso_c_binding, only: c_int, c_float, c_double
  
  implicit none
  
  subroutine cool(X,N) bind(c)
  
  real(c_double), intent(inout) :: X
  integer(c_int), intent(in) :: N

  ...
  
  end subroutine cool
  ```

  `bind(c)` makes the name `cool` available to C/C++.

