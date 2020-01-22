add_executable(namelist namelist_main.f90)
add_test(NAME NamelistRead COMMAND $<TARGET_FILE:namelist>
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})