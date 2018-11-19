cmake_minimum_required (VERSION 3.3)
project(fortran2018io Fortran CXX)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

add_executable(termio terminal_io.f90)
target_compile_options(termio PRIVATE ${FFLAGS})
if(NOT WIN32) # FIXME doable via windows command
  add_test(NAME FortranTerminalIO COMMAND bash -c "./termio <<< 0")
endif()


add_executable(expanduser expanduser.f90)
target_compile_options(expanduser PRIVATE ${FFLAGS})

add_executable(notermsize noenv.f90)
target_compile_options(notermsize PRIVATE ${FFLAGS})
add_test(NAME NoTermSize COMMAND notermsize)

if(f2008)

  add_executable(readonly fileopen-readonly.f90)
  target_compile_options(readonly PRIVATE ${FFLAGS})
  add_test(NAME FortranReadOnly COMMAND readonly)

  add_executable(null devnull.f90 ../perf.f90)
  target_compile_options(null PRIVATE ${FFLAGS})
  add_test(NAME FortranNullfile COMMAND null)
  
endif()

# --- C++17 filesystem ---

if(cxx17)
  add_executable(filesep_cpp filesep.cpp)
  set_property(TARGET filesep_cpp PROPERTY CXX_STANDARD 17)
endif()
