# OpenMPI Examples

This example uses FindMPI Imported Target `MPI::MPI_Fortran` as a modern CMake best practice.
Please `use mpi_f08` to use best of Fortran 2008 polymorphism and unambiguous interfaces.

To run the simplest sort of multi-threaded Fortran program using MPI:

```sh
mpirun -np 4 mpi/mpi_hello
```

## Message Passing MPI

Pass data between two MPI threads

```sh
mpirun -np 2 mpi/mpi_pass
```

## Notes

* https://hpc-forge.cineca.it/files/CoursesDev/public/2017/MasterCS/CalcoloParallelo/MPI_Master2017.pdf
