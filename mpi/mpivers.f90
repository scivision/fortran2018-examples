program mpi_vers
! https://github.com/open-mpi/ompi/blob/master/examples/hello_usempif08.f90

use, intrinsic :: iso_fortran_env, only : compiler_version
use mpi, only : MPI_MAX_LIBRARY_VERSION_STRING, mpi_get_library_version, mpi_init, &
  MPI_COMM_SIZE, mpi_comm_world

implicit none (type, external)

external :: mpi_finalize, mpi_comm_rank

integer :: ierr, id, Nimg, vlen
character(MPI_MAX_LIBRARY_VERSION_STRING) :: version  ! allocatable not ok


print *,compiler_version()

call MPI_INIT(ierr)
if(ierr /= 0) error stop "could not init MPI"

call MPI_COMM_RANK(MPI_COMM_WORLD, id, ierr)
if (ierr /= 0) error stop "could not get MPI rank"

call MPI_COMM_SIZE(MPI_COMM_WORLD, Nimg, ierr)
call MPI_GET_LIBRARY_VERSION(version, vlen, ierr)

print '(A,I3,A,I3,A)', 'MPI: Image ', id, ' / ', Nimg, ':', trim(version)

call MPI_FINALIZE(ierr)
if(ierr /= 0) error stop "could not close MPI"

end program
