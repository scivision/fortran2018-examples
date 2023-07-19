set_property(DIRECTORY PROPERTY LABELS "do_concurrent")

set(names)

if(f202x_do_concurrent)
  list(APPEND names do_concurrent_reduction)
endif()

foreach(t IN LISTS names)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()
