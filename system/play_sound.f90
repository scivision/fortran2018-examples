!! recommend using all lower case filenames and no spaces.
!! plays sound in Fortran 2003+

use, intrinsic :: iso_fortran_env, only : stderr=>error_unit

implicit none

! configure ffplay -- could make if/else to allow other players
character(*),parameter :: playexe='ffplay'
! -autoexit clips off the end of the sound slightly, but otherwise thread hangs open even after Fortran program ends.
character(*),parameter :: cmdopts='-autoexit -loglevel warning -nodisp'

character(:), allocatable :: fn, pcmd
character(2048) :: argv
logical :: fexist
integer :: ierr, istat

call get_command_argument(1, argv, status=ierr)
if (ierr /= 0) error stop 'please include audio filename in command'
fn = trim(argv)

inquire(file=fn, exist=fexist)

if (.not. fexist) then
  write(stderr,*) 'did not find FILE ' // fn
  error stop
endif

pcmd = playexe//' '//cmdopts//' '//trim(fn)

call execute_command_line(pcmd, cmdstat=ierr, exitstat=istat)
if(ierr /= 0) error stop 'could not open player'
if(istat /= 0) error stop 'problem playing file'

end program
