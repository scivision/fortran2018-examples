program mpi_vers
! https://github.com/open-mpi/ompi/blob/master/examples/hello_usempif08.f90

use, intrinsic :: iso_fortran_env
use mpi
implicit none (type, external)

integer :: ierr, id, Nimg, vlen
character(MPI_MAX_LIBRARY_VERSION_STRING) :: version  ! allocatable not ok
external :: mpi_finalize

print *,compiler_version()

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, id, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, Nimg, ierr)
call MPI_GET_LIBRARY_VERSION(version, vlen, ierr)

print '(A,I3,A,I3,A)', 'Image ', id, ' / ', Nimg, ':',version

call MPI_FINALIZE(ierr)

end program
