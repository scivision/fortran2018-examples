set_property(DIRECTORY PROPERTY LABELS submodule)

if(NOT f03selectType)
  return()
endif()

foreach(t IN ITEMS explicit procedure)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()
