set_property(DIRECTORY PROPERTY LABELS overloading)

foreach(t IN ITEMS pragma)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

add_executable(f18es ${PROJECT_SOURCE_DIR}/app/overloading/f2018errorstop.f90)
add_test(NAME F18errorstop COMMAND f18es)
set_property(TEST F18errorstop PROPERTY WILL_FAIL true)
