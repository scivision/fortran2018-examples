# Fortran 2008 contiguous arrays

Fortran 2018 `contiguous` arrays are discussed in pp.139-145 of "Modern Fortran Explained: Incorporating Fortran 2018".
In general, operating on contiguous arrays is faster than non-contiguous arrays.
However, if copy-in, copy-out is needed from non-contiguous arrays, the speed benefit is not guaranteed.
For the basic case, a non-contigous array will have a temporary array copy made for the operation.

A non-contiguous array actual argument into a `contiguous` subroutine dummy argument will create a temporary array copy-in copy-out that is contiguous.
GCC &lt; 9 may fail to do this, that may lead to SIGSEGV or SIGABRT, dependent on array size.

## Example output

```
 .\build\contiguous\contig.exe
At line 56 of file ../contiguous/contiguous.f90
Fortran runtime warning: An array temporary was created
 F contig:   0.001 sec.
 T contig:   0.005 sec.
```

## References

[Fortran 2008 Contiguity](https://www.ibm.com/support/knowledgecenter/bs/SSGH4D_16.1.0/com.ibm.xlf161.aix.doc/language_ref/contiguity.html)
