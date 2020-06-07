add_executable(rotflip test_rot90.f90 rot90.f90)
add_test(NAME array:RotFlip COMMAND $<TARGET_FILE:rotflip>)

add_executable(auto_allocate_array auto_allocate.f90)
add_test(NAME array:AutoAllocate COMMAND $<TARGET_FILE:auto_allocate_array>)

if(f18assumed_rank)
  add_executable(assumed_rank assumed-rank.f90)
  add_test(NAME array:AssumedRank COMMAND assumed_rank)
endif()
