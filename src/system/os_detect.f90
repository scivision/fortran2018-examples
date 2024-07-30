module os_detect

implicit none

contains

function getos()
!! heuristic detection of operating system based on de facto environment variables
character(:), allocatable :: getos
integer :: L, i

call get_environment_variable("HOME", length=L, status=i)
if (i == 0 .and. L > 0) getos = "unix"

call get_environment_variable("USERPROFILE", length=L, status=i)
if (i == 0 .and. L > 0) getos = "windows"

end function getos

end module os_detect
