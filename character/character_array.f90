program character_array
!! examples of using dissimilar character elements in an array
!! the general concept is to make the character(len=) the length of the
!! longest string you will need.
!! trim() each element when actually used if needed.

implicit none (external)

!> specify (*) or maximum len=, else each will be length one.
character(*), parameter :: foo(3) = [character(9) :: 'hi', 'hello', 'greetings']
!! notice how you have to specify the length inside the array.
!! this sometimes has to be done for numerical e.g.
!! mixed integer / real in an array that's actually meant to be real
real, parameter :: mixed(4) = [real :: 27.232, 1, 2, 5.234]

character(9) :: bar(3)

bar = foo

if (.not. all(bar==foo)) error stop


end program