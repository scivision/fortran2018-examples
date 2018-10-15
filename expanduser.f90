module ioutils
implicit none
contains

subroutine expanduser(expandhome, indir)

character(*), intent(in), optional :: indir
character(:), allocatable, intent(out) :: expandhome

character :: filesep
character(256) :: buf
! -- resolve home directory as Fortran does not understand tilde
! works for Linux, Mac, Windows and more

if (present(indir)) then
  if (indir(1:1) /= '~') then
    expandhome = indir
    return
  endif
endif

! assume MacOS/Linux/BSD/Cygwin/WSL
filesep = '/'
call get_environment_variable("HOME", buf)

if (len_trim(buf) == 0) then  ! Windows
  call get_environment_variable("USERPROFILE", buf)
  filesep = char(92)
endif

expandhome = trim(buf) // filesep // indir(3:)


end subroutine expanduser

end module ioutils

!------ demo

program home

use ioutils
implicit none
! explores what '~' means for paths in Fortran
! Note: when testing, enclose argument in '~/test.txt' quotes or 
!  shell will expand '~' before it gets to Fortran!

integer :: fid, ios
character(:), allocatable :: expanded
character(256) :: buf

call get_command_argument(1, buf, status=ios)

if (ios==0) then
  call expanduser(expanded, trim(buf))
else
  call expanduser(expanded)
endif

print '(A)', trim(buf)
print '(A)', expanded

end program
