include(CheckFortranSourceCompiles)

check_fortran_source_compiles("complex :: z; print *,z%re,z%im,z%kind; end" f18prop SRC_EXT f90)
