program basic

use mpi_f08, only : MPI_Init, MPI_Finalize

implicit none (type, external)

print *, "going to init MPI"

call MPI_Init()

print *, "MPI Init OK"

call MPI_Finalize()

print *, "MPI closed"

end program
