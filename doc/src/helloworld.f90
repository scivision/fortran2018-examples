program helloworld
!    Each process prints out a "Hello, world!" message with a process ID
!  Original Author:  John Burkardt
!  Modified: Michael Hirsch, Ph.D.

use mpi_f08
use, intrinsic:: iso_fortran_env, only: dp=>real64
implicit none

integer :: i, Nproc
real(dp) :: wtime

!  Initialize MPI.
call MPI_Init()

!  Get the number of processes.
call MPI_Comm_size(MPI_COMM_WORLD, Nproc)

!  Get the individual process ID.
call MPI_Comm_rank(MPI_COMM_WORLD, i)

!  Print a message.
if (i == 0) then
  wtime = MPI_Wtime()
  print *, 'number of processes: ', Nproc
end if

print *, 'Process ', i

if ( i == 0 ) then
  wtime = MPI_Wtime() - wtime
  print *, 'Elapsed wall clock time = ', wtime, ' seconds.'
end if
!  Shut down MPI.
call MPI_Finalize()

end program

