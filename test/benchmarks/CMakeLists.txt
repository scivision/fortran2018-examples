add_executable(ackermann ${PROJECT_SOURCE_DIR}/app/benchmarks/ackermann.f90)
add_test(NAME Ackermann COMMAND ackermann 2 3)
