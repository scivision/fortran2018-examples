add_executable(contig contiguous.f90)
set_target_properties(contig PROPERTIES EXCLUDE_FROM_ALL $<NOT:$<BOOL:${f08contig}>>)
add_test(NAME contiguous COMMAND $<TARGET_FILE:contig>)
set_tests_properties(contiguous PROPERTIES DISABLED $<NOT:$<BOOL:${f08contig}>>)
