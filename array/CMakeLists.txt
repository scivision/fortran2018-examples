add_executable(rotflip test_rot90.f90 rot90.f90)
target_link_libraries(rotflip ${FLIBS})
target_compile_options(rotflip PRIVATE ${FFLAGS})
add_test(NAME RotFlip COMMAND rotflip)
