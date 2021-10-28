set_directory_properties(PROPERTIES LABELS array)

add_executable(rotflip test_rot90.f90 rot90.f90)
add_test(NAME array:RotFlip COMMAND rotflip)

add_executable(auto_allocate_array auto_allocate.f90)
target_compile_options(auto_allocate_array PRIVATE
"$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fcheck=bounds>"
"$<$<COMPILE_LANG_AND_ID:Fortran,Intel,IntelLLVM>:-CB>"
)
add_test(NAME array:AutoAllocate COMMAND auto_allocate_array)


if(f18assumed_rank)
  add_executable(assumed_rank assumed-rank.f90)
  add_test(NAME array:AssumedRank COMMAND assumed_rank)
endif()
