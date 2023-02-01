set_property(DIRECTORY PROPERTY LABELS pointer)

foreach(t IN ITEMS null_pointer derived_type)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()
