program gitrev
call log_gitrev('.', 'gitrev.log')
end program


subroutine log_gitrev(dir, logfn)
!! Logs current git revision for reproducibility
!!
!! Demonstrates Fortran 2003 Standard character auto-allocation

implicit none

character(*), intent(in) :: dir, logfn
character(:), allocatable :: logpath

logpath =  dir // '/' // logfn

!> write branch
call execute_command_line('git rev-parse --abbrev-ref HEAD > '// logpath)

!> write hash
call execute_command_line('git rev-parse --short HEAD >> '// logpath)

end subroutine log_gitrev

