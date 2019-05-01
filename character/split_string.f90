! split a string about a delimiter token, return part before delim
!
! with regard to length of CHARACTER, it's probably best to pick a length longer than you'll need
! and trim rather than using assumed size, particularly if interfacing with other languages
! CHARACTER assumed size seems to work, but is not reliable in diverse enviroments.
! Your time is more valueable than a few bytes of RAM.

module strutils

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


use strutils, only: split

character(*),parameter :: mystr="hello.txt"
character(:),allocatable :: stem

stem = split(mystr,'.')
print '(A)', stem

if(len(stem) /= 5) error stop 'allocatable character of unexpected length'

end program
