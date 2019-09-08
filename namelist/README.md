# Fortran 90 / 2003 Namelists

Fortran 90 added Namelist to the Fortran standard.
It seems like too few programmers know about namelist, because we see a lot of needless configuration text file parsing.
While
[IBM](https://www.ibm.com/support/knowledgecenter/en/SS3KZ4_9.0.0/com.ibm.xlf111.bg.doc/xlflr/namelistio.htm)
and
[Intel](https://software.intel.com/en-us/fortran-compiler-developer-guide-and-reference-namelist)
describe `namelist`, the application isn't immediately obvious from their didactic explanation.
Python has the
[f90nml](https://f90nml.readthedocs.io/en/latest/)
module for Fortran namelist I/O.
There are strong benefits from using Fortran namelists, now let us give an example of their use.

## Example

Suppose we have a program
[namelist_main.f90](./namelist_main.f90)
that reads configuration parameters from a file
[config.nml](./config.nml)
directly into Fortran variables.
Variables that are not specified in the .nml file are unmodified.
Typically we set default values for all variables before reading the namelist to handle this seamlessly.
If a group isn't specified in the .nml file, it's just passed over silently.

## Caveats

* If you don't leave an extra blank line at the end of .nml, you may get an error like

> Fortran runtime error: End of file

* unused (unspecified) groups must still be specified in .nml without any variables