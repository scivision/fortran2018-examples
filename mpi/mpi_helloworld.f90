program helloworld
!    Each process prints out a "Hello, world!" message with a process ID
!  Original Author:  John Burkardt
!  Modified: Michael Hirsch, Ph.D.

use mpi
use, intrinsic:: iso_fortran_env, only: dp=>real64
implicit none

integer error, i, p
real(dp) wtime


!  Initialize MPI.
call MPI_Init(error)

!  Get the number of processes.
call MPI_Comm_size(MPI_COMM_WORLD, p, error)

!  Get the individual process ID.
call MPI_Comm_rank(MPI_COMM_WORLD, i, error)

!  Print a message.
if (i == 0) then
  wtime = MPI_Wtime()
  print *, 'number of processes: ', p
end if

print *, 'Process ', i

if ( i == 0 ) then
  print *,'HELLO_MPI: Normal end of execution'
  wtime = MPI_Wtime() - wtime
  print *, 'Elapsed wall clock time = ', wtime, ' seconds.'
end if
!  Shut down MPI.
  call MPI_Finalize(error)

end program

