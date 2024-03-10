set_property(DIRECTORY PROPERTY LABELS io)

foreach(t IN ITEMS devnull leading_zeros terminal_size)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()


if(f03selectType)

add_library(logging OBJECT ${PROJECT_SOURCE_DIR}/src/io/logging.f90)

add_executable(append_file append_file.f90 unlink.f90)
target_link_libraries(append_file PRIVATE logging)
add_test(NAME appendFile COMMAND append_file)

endif()

add_executable(termio ${PROJECT_SOURCE_DIR}/app/io/terminal_io.f90)
add_test(NAME terminal
COMMAND ${CMAKE_COMMAND}
  -Dtgt:FILEPATH=$<TARGET_FILE:termio>
  -Dtxt:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/zero.asc
  -P ${PROJECT_SOURCE_DIR}/cmake/test_stdin.cmake
)

set_property(TEST leading_zeros PROPERTY PASS_REGULAR_EXPRESSION "hello1234.5600000")
