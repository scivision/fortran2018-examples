check_fortran_source_compiles(
"program test
character(kind=selected_char_kind('ISO_10646')) :: x
end program"
f03utf8
SRC_EXT f90
)
