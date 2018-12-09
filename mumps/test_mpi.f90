program mpiTypes
use, intrinsic :: iso_fortran_env
use mpi_f08

implicit none

integer :: ierr, mrank, msize, vlen
character(MPI_MAX_LIBRARY_VERSION_STRING) :: version  ! allocatable not ok

print *,compiler_version()

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, mrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, msize, ierr)
call MPI_GET_LIBRARY_VERSION(version, vlen, ierr)

call MPI_FINALIZE()

print '(A,I3,A,I3,A)', 'Image ', mrank, ' / ', msize, ':',version

print '(A25,A7)','type','value'
print '(A25,I4)','mpi_real',mpi_real
print '(A25,I4)','mpi_real8',mpi_real8

end program
