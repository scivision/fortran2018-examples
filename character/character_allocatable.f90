module demo

implicit none (type, external)

contains

pure function drop_last_char(instr)

character(*), intent(in) :: instr
character(:), allocatable :: drop_last_char

drop_last_char = instr(1:len_trim(instr)-1)

end function drop_last_char

end module demo

program character_alloctable
!! shows Fortran 2003 allocatable character and auto-allocated array

use demo, only : drop_last_char
implicit none (type, external)

character(:), allocatable :: flex(:), scalar

scalar = 'hi'
if (len(scalar) /= 2) error stop 'auto-alloc char scalar'
scalar = 'hello'
if (len(scalar) /= 5) error stop 'auto-alloc longer'
scalar = 'bye'
if (len(scalar) /= 3) error stop 'auto-alloc shorter'

if(drop_last_char('hello.') /= 'hello') error stop 'allocatable char function'

flex = [character(9) :: 'hi', 'hello', 'greetings']

if (size(flex) /= 3) error stop
if (len(flex(1)) /= 9) error stop
if (len_trim(flex(1)) /= 2) error stop

flex = [character(8) :: 'bye', 'goodbye', 'farewell', 'sayanora']

if (size(flex) /= 4) error stop
if (len(flex(1)) /= 8) error stop
if (len_trim(flex(1)) /= 3) error stop

end program
