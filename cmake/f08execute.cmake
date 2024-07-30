set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "program test
intrinsic :: execute_command_line

call execute_command_line('echo hello')

end program"
f08execute
)
