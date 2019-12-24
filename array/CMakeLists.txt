add_executable(rotflip test_rot90.f90 rot90.f90)
add_test(NAME RotFlip COMMAND rotflip)

if(f18assumed_rank)
  add_executable(assumed_rank assumed-rank.f90)
  add_test(NAME AssumedRank COMMAND assumed_rank)
endif()