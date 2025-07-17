program character_alloctable
!! shows Fortran 2003 allocatable character and auto-allocated array

implicit none

character(:), allocatable :: flex(:), scalar

valgrind : block

scalar = 'hi'

if (.not.allocated(scalar)) error stop 'F2003 auto-allocate on variable assignment failed'
if (len(scalar) /= 2) error stop 'auto-alloc char scalar'

scalar = 'hello'
if (len(scalar) /= 5) error stop 'auto-alloc 2 => 5'
scalar = 'bye'
if (len(scalar) /= 3) error stop 'auto-alloc 5 => 3'

!> alloctable character function
if(drop_last_char('hello.') /= 'hello') error stop 'allocatable char function'

!> array auto-allocate
flex = [character(9) :: 'hi', 'hello', 'greetings']
if (.not. allocated(flex)) error stop 'F2003 auto-allocate on array assignment failed'

if (size(flex) /= 3) error stop
if (len(flex(1)) /= 9) error stop
if (len_trim(flex(1)) /= 2) error stop

flex = [character(8) :: 'bye', 'goodbye', 'farewell', 'sayanora']

if (size(flex) /= 4) error stop
if (len(flex(1)) /= 8) error stop
if (len_trim(flex(1)) /= 3) error stop

deallocate(flex)
allocate(character(3) :: flex(2))
flex = [character(3) :: 'hi', 'bye']
if (size(flex) /= 2) error stop
if (len(flex(1)) /= 3) error stop "flex: len(flex(1)) /= 3"
if (len_trim(flex(1)) /= 2) error stop "flex: len_trim(flex(1)) /= 2"
if (flex(1) /= 'hi') error stop "flex: flex(1) /= 'hi'"
if (flex(2) /= 'bye') error stop "flex: flex(2) /= 'bye'"

end block valgrind

print *, "OK: allocatable character"

contains

pure function drop_last_char(instr)

character(*), intent(in) :: instr
character(:), allocatable :: drop_last_char

drop_last_char = instr(1:len_trim(instr)-1)

end function drop_last_char

end program
