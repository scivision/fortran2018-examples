set_property(DIRECTORY PROPERTY LABELS submodule)

foreach(t IN ITEMS explicit procedure)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()
