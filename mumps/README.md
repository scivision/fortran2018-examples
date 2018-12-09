# MUMPS

Using MUMPS can be challenging to start in any language due to the number of prereqs that may have to be compiled.
For Linux, MUMPS can be easily obtained:

* Ubuntu/Debian: `apt install libmumps-dev`
* CentOS: `apt install mumps-devel`

The simple example included tests the parallel functionality of MUMPS.

## run MUMPS example
```sh
cd mumps/bin

cmake ..

ctest -V
```
