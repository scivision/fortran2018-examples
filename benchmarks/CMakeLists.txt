add_executable(ackermann ackermann.f90)
add_test(NAME Ackermann COMMAND ackermann)
set_tests_properties(Ackermann PROPERTIES TIMEOUT 10)