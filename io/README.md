# Modern Fortran File I/O

Fortran 77 was the first standard Fortran support for file I/O.
Modern Fortran handles [file I/O](./io) much more cleanly.

## C++17 Filesystem

The GCC 10 and Intel 2020 compiler seem broken for std::filesystem support. Visual Sudio 2019 does work.
See [cxx20-examples](https://github.com/scivision/cxx20-examples) repo for C++17 filesystem examples.

## Writing to /dev/null

Old Fortran programs might write a lot of unnecessary data to disk.
This unnecessary file writing can be the primary wall clock time consumption of the
procedure.
Simply repoint the "open" statements to `/dev/null` to speedup the procedure.
[Benchmarks of NUL vs. scratch vs. file](./devnull.f90)
show NUL can be fastest by far, when file output is not needed with least modification of old source code.

## Read-only files and deletion in Fortran

The `readonly` program shows that even operation system read-only files
can be deleted by Fortran, like `rm -f` with the
`close(u,status='delete')` option:

    ./readonly
