set_property(DIRECTORY PROPERTY LABELS random)

if(NOT f18random)
  message(STATUS "SKIP: random_init not compiler supported")
  return()
endif()

add_executable(random random.f90 random_demo.f90)
add_test(NAME RandomInit COMMAND random)
