set_property(DIRECTORY PROPERTY LABELS random)

if(NOT f18random)
  message(STATUS "SKIP: random_init not compiler supported")
  return()
endif()

add_executable(random_init random_init.f90)
add_test(NAME random_init COMMAND random_init)
