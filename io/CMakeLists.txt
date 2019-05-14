cmake_minimum_required(VERSION 3.3)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(IO_examples C Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

add_library(logging logging.f90)
target_compile_options(logging PRIVATE ${FFLAGS})

add_executable(append_file append_file.f90)
target_compile_options(append_file PRIVATE ${FFLAGS})
target_link_libraries(append_file PRIVATE logging)
add_test(NAME AppendFile COMMAND append_file)

add_executable(termio terminal_io.f90)
target_compile_options(termio PRIVATE ${FFLAGS})
if(NOT WIN32)
  add_test(NAME FortranTerminalIO COMMAND bash -c "$<TARGET_FILE:termio> <<< 0")
endif()

add_executable(leading_zeros leading_zeros.f90)
target_compile_options(leading_zeros PRIVATE ${FFLAGS})
add_test(NAME LeadingZeros COMMAND leading_zeros)
set_tests_properties(LeadingZeros PROPERTIES
  PASS_REGULAR_EXPRESSION "hello1234.5600000")

if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "CMake bug with PGI on Windows -- pgfortran.exe itself works")
else()
  add_executable(expanduser expanduser.f90)
  target_compile_options(expanduser PRIVATE ${FFLAGS})
  add_test(NAME Expanduser COMMAND expanduser)
endif()

add_executable(notermsize noenv.f90)
target_compile_options(notermsize PRIVATE ${FFLAGS})
add_test(NAME NoTermSize COMMAND notermsize)

add_executable(readonly fileopen-readonly.f90)
target_compile_options(readonly PRIVATE ${FFLAGS})
add_test(NAME FortranReadOnly COMMAND readonly)

if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "bug with PGI on Windows--PGI on Linux OK")
else()
  add_executable(null devnull.f90)
  target_compile_options(null PRIVATE ${FFLAGS})
  add_test(NAME FortranNullfile COMMAND null)
endif()
# --- C++17 filesystem ---
# Workaround for PGI not having CXX on Windows and wrong CXX compiler being found
if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI on Windows does not currently have a CXX compiler")
  return()
endif()

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
enable_language(CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(CheckCXXSymbolExists)
CHECK_CXX_SYMBOL_EXISTS(std::filesystem::path::preferred_separator filesystem cxx17)

if(cxx17)
  add_executable(filesep_cpp filesep.cpp)
  set_target_properties(filesep_cpp PROPERTIES CXX_STANDARD 17)
endif()

endif(CMAKE_CXX_COMPILER)
