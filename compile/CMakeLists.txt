add_library(add_dummy OBJECT addone.f90)

# add_library(add_dummy2 OBJECT addone.f90)
# this would fail with Ninja generator because the module name is not unique.
# ninja: build stopped: multiple rules generate compile/add_dummy.mod

add_executable(one_plus_one one_plus_one.f90)
target_link_libraries(one_plus_one PRIVATE add_dummy)
add_test(NAME "1+1" COMMAND one_plus_one)

add_executable(two_plus_one two_plus_one.f90)
target_link_libraries(two_plus_one PRIVATE add_dummy)
add_test(NAME "2+1" COMMAND two_plus_one)
