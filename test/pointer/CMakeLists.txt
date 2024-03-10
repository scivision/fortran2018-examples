set_property(DIRECTORY PROPERTY LABELS pointer)

set(tests null_pointer)
if(f03abstract)
  list(APPEND tests derived_type)
endif()

foreach(t IN LISTS tests)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()
