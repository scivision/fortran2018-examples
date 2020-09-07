module os_detect

implicit none (type, external)

contains

function getos()
!! heuristic detection of operating system based on de facto environment variables
character(256) :: buf
character(:), allocatable :: getos

call get_environment_variable("HOME", buf)
if (len_trim(buf) > 0) getos = "unix"

call get_environment_variable("USERPROFILE", buf)
if (len_trim(buf) > 0) getos = "windows"

end function getos

end module os_detect
