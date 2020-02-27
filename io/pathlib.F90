module pathlib

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none
private
public :: mkdir, copyfile, expanduser, home

contains

integer function copyfile(source, dest) result(istat)
!! overwrites existing file in destination
character(*), intent(in) :: source, dest
character(len(source)) :: src
character(len(dest)) :: dst
logical :: exists
integer :: icstat

#if defined(_WIN32)
!! https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/copy
character(*), parameter :: CMD='copy /y '
src = filesep_swap(source)
dst = filesep_swap(dest)
#else
character(*), parameter ::  CMD='cp -r '
src = source
dst = dest
#endif

call execute_command_line(CMD//src//' '//dst, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat
if (istat /= 0) write(stderr,*) 'ERROR: '//CMD//src//' '//dst

end function copyfile


integer function mkdir(path) result(istat)
!! create a directory, with parents if needed
character(*), intent(in) :: path
character(len(path)) :: p
integer :: icstat

#if defined(_WIN32)
!! https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/md
character(*), parameter :: CMD='mkdir '
p = filesep_swap(path)
#else
character(*), parameter ::  CMD='mkdir -p '
p = path
#endif

call execute_command_line(CMD // p, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat
if (istat /= 0) write(stderr,*) 'ERROR: '//CMD//p

end function mkdir


function filesep_swap(path) result(swapped)
!! swaps '/' to '\' for Windows systems

character(*), intent(in) :: path
character(len(path)) :: swapped
integer :: i

swapped = path
do
  i = index(swapped, '/')
  if (i == 0) exit
  swapped(i:i) = char(92)
end do

end function filesep_swap


function expanduser(indir)
!! resolve home directory as Fortran does not understand tilde
!! works for Linux, Mac, Windows, etc.
character(:), allocatable :: expanduser, homedir
character(*), intent(in) :: indir

if (len_trim(indir) < 1 .or. indir(1:1) /= '~') then
  !! nothing to expand
  expanduser = trim(adjustl(indir))
  return
endif

homedir = home()
if (len_trim(homedir) == 0) then
  !! could not determine the home directory
  expanduser = trim(adjustl(indir))
  return
endif

if (len_trim(indir) < 3) then
  !! ~ or ~/
  expanduser = homedir
else
  !! ~/...
  expanduser = homedir // trim(adjustl(indir(3:)))
endif

end function expanduser


function home()
!! https://en.wikipedia.org/wiki/Home_directory#Default_home_directory_per_operating_system
character(:), allocatable :: home, var
character(256) :: buf
integer :: L, istat

#if defined(_WIN32)
var = "USERPROFILE"
#else
var = "HOME"
#endif

call get_environment_variable(var, buf, length=L, status=istat)
if (L==0 .or. istat /= 0) then
  write(stderr,*) 'ERROR: could not determine home directory from env var ',var
  if (istat==1) write(stderr,*) 'env var ',var,' does not exist.'
  home = ""
else
  home = trim(buf) // '/'
endif

end function home

end module pathlib
