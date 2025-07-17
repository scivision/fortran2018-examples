set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
integer, parameter :: lk = selected_logical_kind(1)
end program"
f2023selected_logical_kind
)
