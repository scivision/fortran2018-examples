set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran
"program test
intrinsic :: selected_char_kind
character(kind=selected_char_kind('ISO_10646')) :: x
end program"
f03utf8
)
