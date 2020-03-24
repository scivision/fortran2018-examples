program character_alloctable
!! shows Fortran 2003 allocatable character and auto-allocated array
implicit none

character(:), allocatable :: flex(:)

flex = [character(9) :: 'hi', 'hello', 'greetings']

if (size(flex) /= 3) error stop
if (len(flex(1)) /= 9) error stop
if (len_trim(flex(1)) /= 2) error stop

flex = [character(8) :: 'bye', 'goodbye', 'farewell', 'sayanora']

if (size(flex) /= 4) error stop
if (len(flex(1)) /= 8) error stop
if (len_trim(flex(1)) /= 3) error stop

end program