submodule (pathlib) pathlib_unix

implicit none

contains

module procedure copyfile

integer :: icstat
!! https://linux.die.net/man/1/cp
character(*), parameter ::  CMD='cp -rf '

call execute_command_line(CMD // source // ' ' // dest, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat

end procedure copyfile


module procedure mkdir
!! create a directory, with parents if needed
integer :: icstat

character(*), parameter ::  CMD='mkdir -p '

call execute_command_line(CMD // path, exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat

end procedure mkdir

end submodule pathlib_unix