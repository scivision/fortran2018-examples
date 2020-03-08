# MPI Examples

This example uses FindMPI Imported Target `MPI::MPI_Fortran` as a modern CMake best practice.

In general in Fortran code it's recommmended to

```fortran
use mpi_f08
```

to use the best of Fortran 2008 polymorphism and unambiguous interfaces.
However to be compatible with MPICH MS-MPI that is currently as MPI version 2.0, we use

```fortran
include 'mpif.h'
```

for maximum backward compatibility.

MSYS2 on Windows can use MS-MPI for Fortran.

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

See
[OpenMPI docs](https://www.open-mpi.org/faq/?category=running#adding-ompi-to-path)
re: setting PATH and LD_LIBRARY_PATH if CMake has trouble finding OpenMPI for a compiler.

* https://hpc-forge.cineca.it/files/CoursesDev/public/2017/MasterCS/CalcoloParallelo/MPI_Master2017.pdf
