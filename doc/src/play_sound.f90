! recommend using all lower case filenames and no spaces.
! plays sound in Fortran 2003+
program mysound
use,intrinsic:: iso_fortran_env,only: error_unit
implicit none

! configure ffplay -- could make if/else to allow other players
character(*),parameter :: playexe='ffplay'
! -autoexit clips off the end of the sound slightly, but otherwise thread hangs open even after Fortran program ends.
character(*),parameter :: cmdopts='-autoexit -loglevel quiet -nodisp'

character(1000) :: fn
character(1000) :: pcmd
!logical :: fexist = .false.
integer :: ios!, fsize, u=-1

call get_command_argument(1,fn,status=ios)
if (ios/=0) stop 'please include audio filename in command'

!open(newunit=u,file=fn,status='old',iostat=ios,action='read')
!if (ios==0) inquire(unit=u,opened=fexist,size=fsize) ! file and not directory
!close(u)

! fsize <= 256 is a little arbitrary--seems there's not yet a compiler-standard way to discriminate between files and diretories.
!if (.not.fexist .or. ios/=0 .or. fsize<=256) then
!    write(error_unit,*) 'did not find FILE ',trim(fn)
!    error stop 'file I/O error'
!endif

pcmd = playexe//' '//cmdopts//' '//trim(fn)

print *,trim(pcmd) ! for debugging

! exitstat only works for wait=.true. by Fortran 2008 spec.
call execute_command_line(pcmd)

end program
