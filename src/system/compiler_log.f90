program logger
implicit none


call compiler_log('./compiler.log')

contains

subroutine compiler_log(logpath)
use, intrinsic :: iso_fortran_env, only: compiler_version, compiler_options

character(*), intent(in) :: logpath
integer :: u

open(newunit=u, file=logpath, form='formatted', status='unknown', action='write')

write(u,'(A,/)') compiler_version()
write(u,'(A)') compiler_options()

close(u)

end subroutine compiler_log
end program
