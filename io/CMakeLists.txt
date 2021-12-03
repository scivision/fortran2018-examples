set_directory_properties(PROPERTIES LABELS io)

add_library(logging OBJECT logging.f90)

add_executable(append_file append_file.f90 unlink.f90)
target_link_libraries(append_file PRIVATE logging)
add_test(NAME appendFile COMMAND append_file)

add_executable(termio terminal_io.f90)
add_test(NAME terminal COMMAND bash -c "$<TARGET_FILE:termio> <<< 0")
set_tests_properties(terminal PROPERTIES DISABLED $<BOOL:${WIN32}>)

add_executable(leading_zeros leading_zeros.f90)
add_test(NAME leading_zeros COMMAND leading_zeros)
set_tests_properties(leading_zeros PROPERTIES
PASS_REGULAR_EXPRESSION "hello1234.5600000"
)

add_executable(notermsize noenv.f90)
add_test(NAME NoTermSize COMMAND notermsize)

add_executable(readonly fileopen-readonly.f90 unlink.f90)
add_test(NAME ReadOnly COMMAND readonly)

add_executable(null devnull.f90)
add_test(NAME nullfile COMMAND null)
