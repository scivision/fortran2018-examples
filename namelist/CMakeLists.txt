add_executable(namelist namelist_main.f90)
target_compile_options(namelist PRIVATE ${FFLAGS})
add_test(NAME Namelist COMMAND namelist WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})