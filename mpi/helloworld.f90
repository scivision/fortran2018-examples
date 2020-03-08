!!    Each process prints out a "Hello, world!" message with a process ID
!!  Original Author:  John Burkardt
!!  Modified: Michael Hirsch, Ph.D.

use mpi  ! Windows Intel 2019 MPI doesn't have mpi_f08 yet (grrr)
use, intrinsic:: iso_fortran_env, only: dp=>real64, compiler_version

implicit none

integer :: i, Nproc, ierr
real(dp) :: wtime

!>  Initialize MPI.
call MPI_Init(ierr)
if (ierr /= 0) error stop 'mpi init error'

!>  Get the number of processes.
call MPI_Comm_size(MPI_COMM_WORLD, Nproc, ierr)

!>  Get the individual process ID.
call MPI_Comm_rank(MPI_COMM_WORLD, i, ierr)

!>  Print a message.
if (i == 0) then
  print *,compiler_version()
  wtime = MPI_Wtime()
  print *, 'number of processes: ', Nproc
end if

print *, 'Process ', i

if ( i == 0 ) then
  wtime = MPI_Wtime() - wtime
  print *, 'Elapsed wall clock time = ', wtime, ' seconds.'
end if

!>  Shut down MPI.
call MPI_Finalize(ierr)
if (ierr /= 0) error stop 'mpi finalize error'

end program

