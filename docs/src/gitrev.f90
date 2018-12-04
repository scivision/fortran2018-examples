program gitrev
call log_gitrev('.', 'gitrev.log')
end program


subroutine log_gitrev(dir, logfn)
! Logs current git revision for reproducibility
!
! Log directory normally is dynamic, for your simultation output
!
! Demonstrates Fortran 2003 Standard character auto-allocation,
!   which helps avoid lots of trim()

  implicit none

  character(*), intent(in) :: dir, logfn
  
  character(:), allocatable :: logpath
  
  logpath =  dir // '/' // logfn

  call execute_command_line('git rev-parse --short HEAD > '// logpath)
  
end subroutine log_gitrev

