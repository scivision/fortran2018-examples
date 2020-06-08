cmake_minimum_required(VERSION 3.15)
project(fortran2018io
LANGUAGES Fortran)
enable_testing()

add_library(logging OBJECT logging.f90)

if(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI doesn't work correctly for this append_file example, even alone")
else()
  add_executable(append_file append_file.f90)
  target_link_libraries(append_file PRIVATE logging pathlib)
  add_test(NAME io:appendFile COMMAND append_file)
endif()

add_executable(termio terminal_io.f90)
if(NOT WIN32)
  add_test(NAME io:terminal COMMAND bash -c "$<TARGET_FILE:termio> <<< 0")
endif()

add_executable(leading_zeros leading_zeros.f90)
add_test(NAME io:leading_zeros COMMAND leading_zeros)
set_tests_properties(io:leading_zeros PROPERTIES
  PASS_REGULAR_EXPRESSION "hello1234.5600000")

add_executable(notermsize noenv.f90)
add_test(NAME io:NoTermSize COMMAND notermsize)

add_executable(readonly fileopen-readonly.f90)
target_link_libraries(readonly pathlib)
add_test(NAME io:ReadOnly COMMAND readonly)

add_executable(null devnull.f90)
add_test(NAME io:nullfile COMMAND null)

# --- pathlib
if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(dir_exist "inquire(directory=path, exist=exists)")
else()
  set(dir_exist "inquire(file=path, exist=exists)")
endif()
configure_file(pathlib.in.f90 pathlib.f90)
add_library(pathlib OBJECT ${CMAKE_CURRENT_BINARY_DIR}/pathlib.f90)
add_executable(test_pathlib test_pathlib.f90)
target_link_libraries(test_pathlib pathlib)
add_test(NAME io:pathlib COMMAND $<TARGET_FILE:test_pathlib>)
if(WIN32)
  target_sources(pathlib PRIVATE pathlib_windows.f90)
else()
  target_sources(pathlib PRIVATE pathlib_unix.f90)
endif()

# future, when c++17 filesystem is better supported in general.
# if(posixio_OK)
#   add_executable(realpath realpath_posix.f90)
# elseif(windowsio_OK)
#   add_executable(realpath fullpath_windows.f90)
# endif()
