# OpenMPI Examples

This example uses FindMPI Imported Target `MPI::MPI_Fortran` as a modern CMake best practice.

To run the simplest sort of multi-threaded Fortran program using MPI:

```sh
mpirun -np 4 mpi/mpi_hello
```

## Message Passing MPI

Pass data between two MPI threads

```sh
mpirun -np 2 mpi/mpi_pass
```
