program basic

use mpi, only : mpi_init

implicit none (type, external)

external :: mpi_finalize
integer :: ierr

print *, "going to init MPI"

call MPI_INIT(ierr)
if(ierr /= 0) error stop "could not init MPI"

print *, "MPI Init OK"

call MPI_FINALIZE(ierr)
if(ierr /= 0) error stop "could not close MPI"

print *, "MPI closed"

end program
