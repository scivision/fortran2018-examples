add_executable(null_pointer null.f90)
add_test(NAME PointerNull COMMAND $<TARGET_FILE:null_pointer>)
