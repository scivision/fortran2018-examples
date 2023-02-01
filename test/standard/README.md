# Fortran standard coding

Examples of standard and non-standard coding

* statement_function.f90: making statement function into regular function
* pause.f90: replace pause with standard statements.
* mkdir.f90: mkdir() is standard Fortran using C

## Fortran 2008 contiguous arrays

Fortran 2018 `contiguous` arrays are discussed in pp.139-145 of "Modern Fortran Explained: Incorporating Fortran 2018".
In general, operating on contiguous arrays is faster than non-contiguous arrays.
A non-contiguous array actual argument into a `contiguous` subroutine dummy argument is **incorrect** syntax.
GCC &lt; 9 may fail with SIGSEGV or SIGABRT in this case, dependent on array size.
Other compiler correct this incorrect syntax by temporary array opy-in, copy-out which is slower.

Example output:

```
 .\build\contiguous\contig.exe
At line 56 of file ../contiguous/contiguous.f90
Fortran runtime warning: An array temporary was created
 F contig:   0.001 sec.
 T contig:   0.005 sec.
```

[Fortran 2008 Contiguity](https://www.ibm.com/support/knowledgecenter/bs/SSGH4D_16.1.0/com.ibm.xlf161.aix.doc/language_ref/contiguity.html)
