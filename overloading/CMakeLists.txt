add_executable(proc pragma.f90)
add_test(NAME overloading:Pragma COMMAND proc)

add_executable(f18es f2018errorstop.f90)
add_test(NAME overloading:F18errorstop COMMAND f18es)
set_tests_properties(overloading:F18errorstop PROPERTIES WILL_FAIL true)
