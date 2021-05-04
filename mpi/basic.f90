program basic

use mpi_f08, only : mpi_init, mpi_finalize

implicit none (type, external)

print *, "going to init MPI"

call MPI_INIT()

print *, "MPI Init OK"

call MPI_FINALIZE()

print *, "MPI closed"

end program
