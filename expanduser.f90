module fsutils
implicit none
contains

function expanduser(indir)

character(:), allocatable :: expanduser
character(*), intent(in) :: indir

! -- resolve home directory as Fortran does not understand tilde
! works for Linux, Mac, Windows and more

if (len_trim(indir) < 1) then
  stop 'must provide path to expand'
elseif (indir(1:1) /= '~') then
  expanduser = trim(adjustl(indir))
  return
elseif (len_trim(indir) < 3) then
  expanduser = homedir()
else
  expanduser = homedir() // trim(adjustl(indir(3:)))
endif

end function expanduser


function homedir()

character(:), allocatable :: homedir
character :: filesep
character(256) :: buf

! assume MacOS/Linux/BSD/Cygwin/WSL
filesep = '/'
call get_environment_variable("HOME", buf)

if (len_trim(buf) == 0) then  ! Windows
  call get_environment_variable("USERPROFILE", buf)
  filesep = char(92)
endif

homedir = trim(buf) // filesep

end function homedir


end module fsutils

!------ demo

program home

use fsutils
implicit none
! explores what '~' means for paths in Fortran
! Note: when testing, enclose argument in '~/test.txt' quotes or 
!  shell will expand '~' before it gets to Fortran!

character(:), allocatable :: expanded
character(256) :: buf

call get_command_argument(1, buf)

expanded = expanduser(trim(buf))

print '(A)', trim(buf)
print '(A)', expanded

end program
