set_property(DIRECTORY PROPERTY LABELS character)

set(tests ascii character_array charlen
color_text
print_vs_write overwrite_stdout special_characters str2int utf8)

foreach(f IN ITEMS f03character_allocatable f2023character_allocatable)
  if(${f})
    list(APPEND tests ${f})
  endif()
endforeach()

foreach(t IN LISTS tests)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

set_property(TARGET utf8 PROPERTY EXCLUDE_FROM_ALL $<NOT:$<BOOL:${f03utf8}>>)
set_property(TEST utf8 PROPERTY DISABLED $<NOT:$<BOOL:${f03utf8}>>)

add_executable(string_utils ${PROJECT_SOURCE_DIR}/src/character/string_utils.f90 test_string.f90)
add_test(NAME utils COMMAND string_utils)
