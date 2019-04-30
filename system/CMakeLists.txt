cmake_minimum_required (VERSION 3.1)
project(f08exe Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08command.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f18errorstop.cmake)

add_executable(color color_text.f90)
target_compile_options(color PRIVATE ${FFLAGS})
target_link_libraries(color ${FLIBS})

if(f08command)
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
endif()

if(f18errorstop)
  add_executable(callpython call_python_script.f90)
  target_compile_options(callpython PRIVATE ${FFLAGS})
  target_link_libraries(callpython osdet ${FLIBS})
endif()
