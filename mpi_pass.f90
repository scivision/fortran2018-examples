program main
! passes data between two threads

!  Author:  John Burkardt
  use mpi
  implicit none

  character(len=10) :: time
  integer count
  real data(0:99), value(200)
  integer dest, i, ierr, num_procs, rank, tag
  integer status(MPI_Status_size)

!  Initialize MPI.
  call MPI_Init ( ierr )

!  Determine this process's rank.
  call MPI_Comm_rank ( MPI_COMM_WORLD, rank, ierr )

!  Find out the number of processes available.
  call MPI_Comm_size ( MPI_COMM_WORLD, num_procs, ierr )
  if (num_procs.lt.2) stop 'must have at least 2 threads, try using mpirun -np 2 pass'

!  Have Process 0 say hello.
  if ( rank == 0 ) then
    print *, '  An MPI test program. number of processes available ', num_procs
  end if

!  Process 0 expects to receive as much as 200 real values, from any source.
  if ( rank == 0 ) then
    tag = 55
    call MPI_Recv ( value, 200, MPI_REAL, MPI_ANY_SOURCE, tag, &
      MPI_COMM_WORLD, status, ierr )

    print *, rank, ' Got data from processor ', status(MPI_SOURCE)

    call MPI_Get_count ( status, MPI_REAL, count, ierr )

    print *, rank, ' Got ', count, ' elements.'

    print *, rank, ' value(5) = ', value(5)

!  Process 1 sends 100 real values to process 0.
  else if ( rank == 1 ) then
    print *, rank, ' - setting up data to send to process 0.'

    do i = 0, 99
      data(i) = real ( i )
    end do

    dest = 0
    tag = 55
    call MPI_Send ( data, 100, MPI_REAL, dest, tag, MPI_COMM_WORLD, ierr )
  else
    print *, rank, ' - MPI has no work for me!'
  end if

  call MPI_Finalize ( ierr )

  if ( rank == 0 ) then
    call date_and_time (time = time )
    print *, '  Normal end of execution. ',time
  end if

end program
