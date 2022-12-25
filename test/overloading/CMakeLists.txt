set_property(DIRECTORY PROPERTY LABELS overloading)

add_executable(proc pragma.f90)
add_test(NAME Pragma COMMAND proc)

add_executable(f18es ${PROJECT_SOURCE_DIR}/app/overloading/f2018errorstop.f90)
add_test(NAME F18errorstop COMMAND f18es)
set_property(TEST F18errorstop PROPERTY WILL_FAIL true)
