program hw_mpi
!!    Each process prints out a "Hello, world!" message with a process ID
!!  Original Author:  John Burkardt
!!  Modified: Michael Hirsch, Ph.D.
!!  Modified: Jeff Hammond

use mpi_f08, only : MPI_Init, MPI_Finalize, MPI_Wtime, &
                    MPI_Comm_size, MPI_Comm_rank, MPI_COMM_WORLD, &
                    MPI_Barrier

use, intrinsic:: iso_fortran_env, only: dp=>real64, compiler_version

implicit none (type, external)

integer :: me, np, i
real(dp) :: wtime

!>  Initialize MPI.
call MPI_Init()

!>  Get the number of processes.
call MPI_Comm_size(MPI_COMM_WORLD, np)

!>  Get the individual process ID.
call MPI_Comm_rank(MPI_COMM_WORLD, me)

!>  Print a message.
if (me == 0) then
  print *,compiler_version()
  wtime = MPI_Wtime()
  print *, 'number of processes: ', np
end if

!> Print process ranks with total ordering
do i=0,np
    call MPI_Barrier(MPI_COMM_WORLD)
    if (me.eq.i) print *, 'Process ', me
end do

if ( me == 0 ) then
  wtime = MPI_Wtime() - wtime
  print *, 'Elapsed wall clock time = ', wtime, ' seconds.'
end if

!>  Shut down MPI.
call MPI_Finalize()

end program
