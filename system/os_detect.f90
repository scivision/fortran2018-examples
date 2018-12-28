module os_detect

implicit none

contains

function getos()
!! heuristic detection of operating system based on de factor environment variables
character(256) :: buf
character(:), allocatable :: getos

call get_environment_variable("HOME", buf)
if (len_trim(buf) > 0) then
  getos = "unix"
  return
endif

call get_environment_variable("USERPROFILE", buf)
if (len_trim(buf) > 0) then
  getos = "windows"
  return
endif

end function getos

end module os_detect