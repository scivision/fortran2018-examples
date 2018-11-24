# Strings

## Split strings about delimiter

This splits a string once around a delimiter:

    ./split

And notes that it is probably best to use fixed length CHARACTER longer
than you'll need. If you're trying to load and parse a complicated text
file, it is perhaps better to load that file first in Python, parse it,
then pass it to Fortran via f2py (load Fortran code as a Python module).
