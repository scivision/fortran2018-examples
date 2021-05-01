program mpi_pass
!! passes data between two threads
!!  Author:  John Burkardt
!!  Modified: Jeff Hammond
use, intrinsic :: iso_fortran_env, only: sp=>real32, compiler_version

use mpi_f08, only : MPI_Init, MPI_Finalize, MPI_Wtime, &
                    MPI_Comm_size, MPI_Comm_rank, MPI_COMM_WORLD, &
                    MPI_Barrier, MPI_Send, MPI_Recv, &
                    MPI_Get_count, MPI_STATUS_SIZE, &
                    MPI_REAL, MPI_ANY_SOURCE, MPI_ANY_TAG, &
                    MPI_TAG, MPI_SOURCE, MPI_STATUS

implicit none (type, external)

character(10) :: time
integer :: mcount
real(sp) :: dat(0:99), val(200)
integer :: dest, i, num_procs, rank, tag
type(MPI_STATUS) :: status  !< MPI_F08

!  Initialize MPI.
call MPI_Init()

!  Determine this process's rank.
call MPI_Comm_rank ( MPI_COMM_WORLD, rank)

!  Find out the number of processes available.
call MPI_Comm_size ( MPI_COMM_WORLD, num_procs)
if (num_procs < 2) error stop 'two threads are required, use: mpiexec -np 2 ./mpi_pass'

call MPI_Barrier(MPI_COMM_WORLD)

!  Have Process 0 say hello.
if ( rank == 0 ) then
  print *,compiler_version()
  print *, '  An MPI test program. number of processes available ', num_procs
end if

call MPI_Barrier(MPI_COMM_WORLD)

!  Process 0 expects to receive as much as 200 real values, from any source.
if ( rank == 0 ) then
  call MPI_Recv (val, size(val), MPI_REAL, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status)

  print *, rank, ' Got data from processor ', status%MPI_SOURCE, 'tag',status%MPI_TAG

  call MPI_Get_count ( status, MPI_REAL, mcount)

  print *, rank, ' Got ', mcount, ' elements.'

  print *, rank, ' val(5) = ', val(5)

!  Process 1 sends 100 real values to process 0.
else if ( rank == 1 ) then
  print *, rank, ' - setting up data to send to process 0.'

  do i = 0, 99
    dat(i) = real ( i )
  end do

  dest = 0
  tag = 55
  call MPI_Send ( dat, size(dat), MPI_REAL, dest, tag, MPI_COMM_WORLD)
else
  print *, rank, ' - MPI has no work for me!'
end if

if ( rank == 0 ) then
  call date_and_time (time = time )
  print *, '  Normal  execution. ',time
end if

call MPI_Finalize()

end program
