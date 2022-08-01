set_property(DIRECTORY PROPERTY LABELS contiguous)

add_executable(contig contiguous.f90)
set_property(TARGET contig PROPERTY EXCLUDE_FROM_ALL $<NOT:$<BOOL:${f08contig}>>)
add_test(NAME contiguous COMMAND contig)
set_property(TEST contiguous PROPERTY DISABLED $<NOT:$<BOOL:${f08contig}>>)
