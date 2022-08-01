set_property(DIRECTORY PROPERTY LABELS system)

add_executable(color color_text.f90)
add_test(NAME Color COMMAND color)

add_library(osdet OBJECT os_detect.f90)

add_executable(complog compiler_log.f90)
add_test(NAME Compiler COMMAND complog)

find_package(Python3 COMPONENTS Interpreter)
add_executable(callpython call_python_script.f90)
add_test(NAME CallPython COMMAND callpython)
set_property(TEST CallPython PROPERTY DISABLED $<NOT:$<BOOL:${Python3_FOUND}>>)

find_program(FFPLAY NAMES ffplay)
add_executable(playsound play_sound.f90)
add_test(NAME PlaySound COMMAND playsound ${CMAKE_CURRENT_SOURCE_DIR}/bell.aac)
set_property(TEST PlaySound PROPERTY TIMEOUT 15)
set_property(TEST PlaySound PROPERTY DISABLED $<NOT:$<BOOL:${FFPLAY}>>)
