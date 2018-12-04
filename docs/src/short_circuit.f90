program short_circuit_logic
!! Fortran does [NOT have short-circuit logic](https://www.scivision.co/fortran-short-circuit-logic/), 
!! but some compilers enact short-circuit logic anyway.
!! This can lead to confusion between different users.
!!
!! Compilers will definitely let you compile this, but some will segfault on run.
!! NAG will raise Runtime error noting reference to not present variable.
!! 

implicit none

call msg_bad_code('I did it')

contains


subroutine msg_bad_code(txt, b)

character(*), intent(in) :: txt
!! text to write if b==0
integer, intent(in), optional :: b
!! just an input value

if (present(b) .and. b/=0) print *,'oops: ' // txt

end subroutine msg_bad_code


end program
