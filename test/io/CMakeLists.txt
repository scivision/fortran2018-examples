set_property(DIRECTORY PROPERTY LABELS io)

add_library(logging OBJECT ${PROJECT_SOURCE_DIR}/src/io/logging.f90)

add_executable(append_file append_file.f90 unlink.f90)
target_link_libraries(append_file PRIVATE logging)
add_test(NAME appendFile COMMAND append_file)

add_executable(termio ${PROJECT_SOURCE_DIR}/app/io/terminal_io.f90)
add_test(NAME terminal
COMMAND ${CMAKE_COMMAND}
  -Dtgt:FILEPATH=$<TARGET_FILE:termio>
  -Dtxt:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/zero.asc
  -P ${PROJECT_SOURCE_DIR}/cmake/test_stdin.cmake
)

add_executable(leading_zeros leading_zeros.f90)
add_test(NAME leading_zeros COMMAND leading_zeros)
set_property(TEST leading_zeros PROPERTY PASS_REGULAR_EXPRESSION "hello1234.5600000")

add_executable(notermsize noenv.f90)
add_test(NAME NoTermSize COMMAND notermsize)

add_executable(null devnull.f90)
add_test(NAME nullfile COMMAND null)
