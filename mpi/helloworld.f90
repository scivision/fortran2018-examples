program hw_mpi
!!    Each process prints out a "Hello, world!" message with a process ID
!!  Original Author:  John Burkardt
!!  Modified: Michael Hirsch, Ph.D.

use mpi_f08, only : mpi_init, mpi_comm_size, mpi_comm_world, mpi_wtime, mpi_comm_rank, mpi_finalize
use, intrinsic:: iso_fortran_env, only: dp=>real64, compiler_version

implicit none (type, external)

integer :: id, Nproc
real(dp) :: wtime

!>  Initialize MPI.
call MPI_Init()

!>  Get the number of processes.
call MPI_Comm_size(MPI_COMM_WORLD, Nproc)

!>  Get the individual process ID.
call MPI_Comm_rank(MPI_COMM_WORLD, id)

!>  Print a message.
if (id == 0) then
  print *,compiler_version()
  wtime = MPI_Wtime()
  print *, 'number of processes: ', Nproc
end if

print *, 'Process ', id

if (id == 0) then
  wtime = MPI_Wtime() - wtime
  print *, 'Elapsed wall clock time = ', wtime, ' seconds.'
end if

!>  Shut down MPI.
call MPI_Finalize()

end program
