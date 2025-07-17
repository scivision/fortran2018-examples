set_property(DIRECTORY PROPERTY LABELS system)

if(python)
  find_package(Python COMPONENTS Interpreter)

  add_executable(callpython call_python_script.f90)
  add_test(NAME CallPython COMMAND callpython ${Python_EXECUTABLE})
  set_tests_properties(CallPython PROPERTIES
  DISABLED $<OR:$<NOT:$<BOOL:${f08execute}>>,$<NOT:$<BOOL:${Python_Interpreter_FOUND}>>>
  LABELS "python"
  )
endif()


find_program(FFPLAY NAMES ffplay)
add_executable(playsound play_sound.f90)
add_test(NAME PlaySound COMMAND playsound ${CMAKE_CURRENT_SOURCE_DIR}/bell.aac)
set_property(TEST PlaySound PROPERTY DISABLED $<OR:$<BOOL:$ENV{CI}>,$<NOT:$<BOOL:${FFPLAY}>>>)
