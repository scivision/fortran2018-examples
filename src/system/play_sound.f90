program play_sound
!! recommend using all lower case filenames and no spaces.
!! plays sound in Fortran 2003+

implicit none

! configure ffplay -- could make if/else to allow other players
character(*),parameter :: playexe='ffplay'
! -autoexit clips off the end of the sound slightly, but otherwise thread hangs open even after Fortran program ends.
character(*),parameter :: cmdopts='-autoexit -loglevel warning -nodisp'

character(:), allocatable :: pcmd, buf
logical :: fexist
integer :: ierr, istat, L

valgrind : block

call get_command_argument(1, length=L, status=ierr)
if (ierr /= 0) error stop "please specify sound file"
allocate(character(L) :: buf)
call get_command_argument(1, value=buf)

inquire(file=buf, exist=fexist)

if (.not. fexist) error stop 'did not find FILE ' // buf

pcmd = playexe//' '//cmdopts//' '//trim(buf)

call execute_command_line(pcmd, cmdstat=ierr, exitstat=istat)
if(ierr /= 0) error stop 'could not open player'
if(istat /= 0) error stop 'problem playing file'

end block valgrind

end program
