add_executable(rotflip test_rot90.f90 rot90.f90)
add_test(NAME RotFlip COMMAND rotflip)
