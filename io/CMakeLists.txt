cmake_minimum_required(VERSION 3.14...3.21)
project(fortran2018io
  LANGUAGES Fortran)
enable_testing()

set_directory_properties(PROPERTIES LABELS io)

if(f08block)
  add_library(logging OBJECT logging.f90)

  add_executable(append_file append_file.f90)
  target_link_libraries(append_file PRIVATE logging pathlib)
  add_test(NAME io:appendFile COMMAND append_file)
endif(f08block)

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
add_library(pathlib OBJECT pathlib.f90)
if(WIN32)
  target_sources(pathlib PRIVATE pathlib_windows.f90)
else()
  target_sources(pathlib PRIVATE pathlib_unix.f90)
endif()
if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  target_sources(pathlib PRIVATE pathlib_intel.f90)
else()
  target_sources(pathlib PRIVATE pathlib_gcc.f90)
endif()

add_executable(test_pathlib test_pathlib.f90)
target_link_libraries(test_pathlib pathlib)
add_test(NAME io:pathlib COMMAND $<TARGET_FILE:test_pathlib>)

# future, when c++17 filesystem is better supported in general.
# if(posixio_OK)
#   add_executable(realpath realpath_posix.f90)
# elseif(windowsio_OK)
#   add_executable(realpath fullpath_windows.f90)
# endif()
