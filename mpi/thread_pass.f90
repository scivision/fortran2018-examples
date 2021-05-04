program mpi_pass
!! passes data between two threads
!! This would be much simpler using Fortran 2008 coarray syntax
!!
!!  Original author:  John Burkardt
use, intrinsic :: iso_fortran_env, only: real32, compiler_version, int64
use mpi_f08, only : mpi_status, mpi_comm_world, mpi_init, mpi_get_count, &
  mpi_real, mpi_any_source, mpi_any_tag, mpi_source, mpi_tag, mpi_comm_size, &
  mpi_comm_rank, mpi_recv, mpi_send, mpi_finalize

implicit none (type, external)

integer :: mcount
real(real32) :: dat(0:99), val(200)
integer :: dest, i, num_procs, id, tag
integer(int64) :: tic, toc, rate

type(MPI_STATUS) :: status

call system_clock(tic)

call MPI_Init()

!  Determine this process's ID.
call MPI_Comm_rank(MPI_COMM_WORLD, id)

!  Find out the number of processes available.
call MPI_Comm_size(MPI_COMM_WORLD, num_procs)

if (num_procs < 2) error stop 'two threads are required, use: mpiexec -np 2 ./mpi_pass'

if (id == 0) then
  print *,compiler_version()
  print *, 'Number of MPI processes available ', num_procs
end if

!  Process 0 expects to receive as much as 200 real values, from any source.
select case (id)
case (0)
  print *, id, "waiting for MPI_send() from image 1"
  call MPI_Recv (val, size(val), MPI_REAL, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status)

  print *, id, ' Got data from processor ', status%MPI_SOURCE, 'tag',status%MPI_TAG

  call MPI_Get_count(status, MPI_REAL, mcount)

  print *, id, ' Got ', mcount, ' elements.'

  if (val(5) /= 4) error stop "data did not transfer"

!  Process 1 sends 100 real values to process 0.
case (1)
  print *, id, ': setting up data to send to process 0.'

  dat = real([(i, i = 0, 99)])

  dest = 0
  tag = 55
  call MPI_Send(dat, size(dat), MPI_REAL, dest, tag, MPI_COMM_WORLD)
case default
  print *, id, ': MPI has no work for image', id
end select

call MPI_Finalize()


if (id == 0) then
  call system_clock(toc)
  call system_clock(count_rate=rate)
  print *, 'Run time in seconds: ',real(toc - tic)  / rate
end if

end program
