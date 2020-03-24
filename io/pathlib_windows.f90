submodule (pathlib) pathlib_windows

implicit none

contains

module procedure copyfile

integer :: icstat
!! https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/copy
character(*), parameter :: CMD='copy /y '

call execute_command_line(CMD // filesep_swap(source) // ' ' // filesep_swap(dest), exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat

end procedure copyfile


module procedure mkdir
!! create a directory, with parents if needed
integer :: icstat
!! https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/md
character(*), parameter :: CMD='mkdir '

call execute_command_line(CMD // filesep_swap(path), exitstat=istat, cmdstat=icstat)
if (istat == 0 .and. icstat /= 0) istat = icstat

end procedure mkdir


end submodule pathlib_windows