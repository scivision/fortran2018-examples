cmake_minimum_required(VERSION 3.14...3.20)
project(F18system Fortran)

enable_testing()

set_directory_properties(PROPERTIES LABELS system)

add_executable(color color_text.f90)
add_test(NAME system:Color COMMAND color)

add_library(osdet OBJECT os_detect.f90)

add_executable(complog compiler_log.f90)
add_test(NAME system:Compiler COMMAND complog)

find_package(Python3 COMPONENTS Interpreter)
add_executable(callpython call_python_script.f90)
add_test(NAME system:CallPython COMMAND callpython)
set_tests_properties(system:CallPython PROPERTIES DISABLED $<NOT:$<BOOL:${Python3_FOUND}>>)

find_program(FFPLAY NAMES ffplay)
add_executable(playsound play_sound.f90)
add_test(NAME system:PlaySound COMMAND $<TARGET_FILE:playsound> ${CMAKE_CURRENT_SOURCE_DIR}/bell.aac)
set_tests_properties(system:PlaySound PROPERTIES
TIMEOUT 15
DISABLED $<NOT:$<BOOL:${FFPLAY}>>
)
