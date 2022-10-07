
module strutils
!! split a string about a delimiter token, return part before delim

implicit none

contains

pure function split(instr,  delimiter)

character(*), intent(in) :: instr
character(1), intent(in) :: delimiter
character(:), allocatable :: split

integer :: idx

idx = scan(instr, delimiter)
split = instr(1:idx-1)

end function split

end module strutils


program split_string
use strutils, only: split
!! split a string about a delimiter token, return part before delim
implicit none

character(*),parameter :: mystr="hello.txt"
character(:),allocatable :: stem

stem = split(mystr,'.')
print '(A)', stem

if (len(stem) /= 5) error stop 'allocatable character of unexpected length'

end program
