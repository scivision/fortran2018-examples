# Strings

Strings / character in Fortran is often easier than is commonly thought, as long as the characteristic particular to Fortran are kept in mind.
These examples aim to raise awareness of how to use `character` type in Fortran.

## character array with dissimilar length

Although it is possible to use `allocatable` character array, the
[character_array.f90](./character_array.f90)
example shows the use of fixed lengh `character` array with each element having a distinct length.

## Split strings about delimiter

This splits a string once around a delimiter:

    ./split

And notes that it is probably best to use fixed length CHARACTER longer
than you'll need.
If you're trying to load and parse a complicated text
file, it is perhaps better to load that file first in Python, parse it,
then pass it to Fortran via f2py (load Fortran code as a Python module).
