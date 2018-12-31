cmake_minimum_required (VERSION 3.1)
project(f08exe Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(hasParent AND NOT f08command)
  return()
elseif(NOT f08command)
  message(FATAL_ERROR "Fortran 2008 execute_command_line necessary for these programs.")
endif()

add_library(osdet os_detect.f90)
target_compile_options(osdet PRIVATE ${FFLAGS})

add_executable(gitrev gitrev.f90)
target_compile_options(gitrev PRIVATE ${FFLAGS})
target_link_libraries(gitrev ${FLIBS})
add_test(NAME FortranGit COMMAND gitrev)

add_executable(complog compiler_log.f90)
target_compile_options(complog PRIVATE ${FFLAGS})
target_link_libraries(complog ${FLIBS})
add_test(NAME FortranCompiler COMMAND complog)

add_executable(playsound play_sound.f90)
target_compile_options(playsound PRIVATE ${FFLAGS})
target_link_libraries(playsound ${FLIBS})

if(f18errorstop)
  add_executable(callpython call_python_script.f90)
  target_compile_options(callpython PRIVATE ${FFLAGS})
  target_link_libraries(callpython osdet ${FLIBS})
endif()
