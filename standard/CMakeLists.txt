
add_executable(shortcircuit short_circuit.f90)
# shaky result, don't CI test

add_executable(bitpat bitpat.f90)
add_test(NAME standard:bit_pattern COMMAND $<TARGET_FILE:bitpat>)

add_executable(do_cycle do_cycle.f90)
add_test(NAME standard:doCycle COMMAND $<TARGET_FILE:do_cycle>)

# --- logical / boolean sized
include(CheckTypeSize)
set(CMAKE_EXTRA_INCLUDE_FILES stdbool.h)
check_type_size(bool _size_bool)
if(_size_bool EQUAL 1)
  add_executable(boolean_c logical_kind.c)
  add_test(NAME standard:boolean_c COMMAND $<TARGET_FILE:boolean_c>)

  add_executable(logical_f logical_kind.f90)
  add_test(NAME standard:logical_kind COMMAND $<TARGET_FILE:logical_f>)
else()
  message(STATUS "SKIP: This platform does not have 1-byte C bool")
endif()
# ---
add_executable(big_integer big_integer.f90)
add_test(NAME standard:big_integer COMMAND $<TARGET_FILE:big_integer>)

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
add_test(NAME standard:sleep COMMAND $<TARGET_FILE:sleep_demo> 150)

# --
add_executable(statement statement_function.f90)
add_test(NAME standard:statement_function COMMAND statement)
