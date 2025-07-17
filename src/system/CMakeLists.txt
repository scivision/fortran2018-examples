set_property(DIRECTORY PROPERTY LABELS system)

if(f08execute)
find_package(Python COMPONENTS Interpreter)

add_executable(callpython call_python_script.f90)
add_test(NAME CallPython COMMAND callpython ${Python_EXECUTABLE})
set_property(TEST CallPython PROPERTY DISABLED $<NOT:$<BOOL:${Python_FOUND}>>)

find_program(FFPLAY NAMES ffplay)
add_executable(playsound play_sound.f90)
add_test(NAME PlaySound COMMAND playsound ${CMAKE_CURRENT_SOURCE_DIR}/bell.aac)
set_property(TEST PlaySound PROPERTY DISABLED $<NOT:$<BOOL:${FFPLAY}>>)
endif()
