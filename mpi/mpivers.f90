program mpi_vers
! https://github.com/open-mpi/ompi/blob/master/examples/hello_usempif08.f90

use, intrinsic :: iso_fortran_env, only : compiler_version

use mpi_f08, only : MPI_Init, MPI_Finalize, MPI_Comm_rank, MPI_Comm_size, MPI_COMM_WORLD, &
                    MPI_Barrier, MPI_Get_library_version, MPI_MAX_LIBRARY_VERSION_STRING

implicit none (type, external)

integer :: id, Nimg, vlen
character(MPI_MAX_LIBRARY_VERSION_STRING) :: version  ! allocatable not ok

call MPI_Init()

call MPI_Comm_rank(MPI_COMM_WORLD, id)

call MPI_Comm_size(MPI_COMM_WORLD, Nimg)
call MPI_Get_library_version(version, vlen)

if (id .eq. 0) then
    print *,compiler_version()
end if
call MPI_Barrier(MPI_COMM_WORLD)
print '(A,I3,A,I3,A)', 'MPI: Image ', id, ' / ', Nimg, ':', trim(version)

call MPI_Finalize()

end program
