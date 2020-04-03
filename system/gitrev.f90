program demo_git

implicit none (external)

call log_gitrev('.', 'gitrev.log')
contains

subroutine log_gitrev(dir, logfn)
!! Logs current git revision for reproducibility
!!
!! Demonstrates Fortran 2003 Standard character auto-allocation
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

character(*), intent(in) :: dir, logfn
character(:), allocatable :: logpath
integer :: ierr

logpath =  dir // '/' // logfn

call execute_command_line('git rev-parse --abbrev-ref HEAD > '// logpath, cmdstat=ierr)
if(ierr /= 0) then
  write(stderr, *) 'failed to log Git branch'
  return
endif

call execute_command_line('git rev-parse --short HEAD >> '// logpath, cmdstat=ierr)
if(ierr /= 0) then
  write(stderr, *) 'failed to log Git hash'
  return
endif

end subroutine log_gitrev

end program