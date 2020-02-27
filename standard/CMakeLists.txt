
add_executable(shortcircuit short_circuit.f90)
# shaky result, don't CI test

add_executable(bitpat bitpat.f90)
add_test(NAME BitPattern COMMAND bitpat)

add_executable(justwait pause.f90)
# NO test

# -- sleep
add_library(sleep_std OBJECT sleep_std.F90)
target_include_directories(sleep_std INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
  $<INSTALL_INTERFACE:include>)
set_target_properties(sleep_std PROPERTIES
  Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)

add_executable(sleep_demo sleep_demo.f90)
target_link_libraries(sleep_demo sleep_std)
add_test(NAME StandardSleep COMMAND $<TARGET_FILE:sleep_demo> 150)

# --
add_executable(statement statement_function.f90)
add_test(NAME Statement COMMAND statement)
