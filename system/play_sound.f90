!! recommend using all lower case filenames and no spaces.
!! plays sound in Fortran 2003+

use,intrinsic:: iso_fortran_env,only: error_unit
implicit none

! configure ffplay -- could make if/else to allow other players
character(*),parameter :: playexe='ffplay'
! -autoexit clips off the end of the sound slightly, but otherwise thread hangs open even after Fortran program ends.
character(*),parameter :: cmdopts='-autoexit -loglevel warning -nodisp'

character(1000) :: fn
character(1000) :: pcmd
logical :: fexist
integer :: ios, fsize, u

call get_command_argument(1, fn, status=ios)
if (ios/=0) error stop 'please include audio filename in command'

open(newunit=u, file=fn, status='old', iostat=ios, action='read')
if (ios==0) inquire(unit=u, opened=fexist, size=fsize)
close(u)

if (.not. fexist .or. ios/=0 .or. fsize<=256) then
  write(error_unit,*) 'did not find FILE ',trim(fn)
  error stop 'file I/O error'
endif

pcmd = playexe//' '//cmdopts//' '//trim(fn)

print *,trim(pcmd) ! for debugging

! exitstat only works for wait=.true. by Fortran 2008 spec.
call execute_command_line(pcmd, cmdstat=ios)
if(ios /= 0) error stop 'could not open player'

end program
