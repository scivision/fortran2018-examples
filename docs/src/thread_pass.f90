program main
! passes data between two threads

!  Author:  John Burkardt
  use, intrinsic :: iso_fortran_env, only: stderr=>error_unit
  use mpi_f08
  implicit none

  character(10) :: time
  integer :: mcount
  real :: dat(0:99), val(200)
  integer :: dest, i, num_procs, rank, tag
  type(MPI_STATUS) :: status

!  Initialize MPI.
  call MPI_Init()

!  Determine this process's rank.
  call MPI_Comm_rank ( MPI_COMM_WORLD, rank)

!  Find out the number of processes available.
  call MPI_Comm_size ( MPI_COMM_WORLD, num_procs)
  if (num_procs < 2) then
    write(stderr,*) 'ERROR: two threads are required, use:'
    write(stderr,*) 'mpiexec -np 2 ./mpi_pass'
    stop 1
  endif

!  Have Process 0 say hello.
  if ( rank == 0 ) then
    print *, '  An MPI test program. number of processes available ', num_procs
  end if

!  Process 0 expects to receive as much as 200 real values, from any source.
  if ( rank == 0 ) then
    tag = 55
    call MPI_Recv (val, size(val), MPI_REAL, MPI_ANY_SOURCE, tag, MPI_COMM_WORLD, status)

    print *, rank, ' Got data from processor ', status%MPI_SOURCE

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

  call MPI_Finalize()

  if ( rank == 0 ) then
    call date_and_time (time = time )
    print *, '  Normal  execution. ',time
  end if

end program
