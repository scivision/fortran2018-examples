check_source_compiles(Fortran
"program test
character(kind=selected_char_kind('ISO_10646')) :: x
end program"
f03utf8)
