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
add_test(NAME Color COMMAND color)

if(f08command)
add_library(osdet os_detect.f90)
target_compile_options(osdet PRIVATE ${FFLAGS})
target_link_libraries(osdet ${FLIBS})

add_executable(gitrev gitrev.f90)
target_compile_options(gitrev PRIVATE ${FFLAGS})
target_link_libraries(gitrev ${FLIBS})
add_test(NAME Git COMMAND gitrev)

add_executable(complog compiler_log.f90)
target_compile_options(complog PRIVATE ${FFLAGS})
target_link_libraries(complog ${FLIBS})
add_test(NAME Compiler COMMAND complog)

find_package(FFMPEG COMPONENTS PLAY)

add_executable(playsound play_sound.f90)
target_compile_options(playsound PRIVATE ${FFLAGS})
target_link_libraries(playsound ${FLIBS})
if(FFMPEG_FOUND)
  add_test(NAME PlaySound COMMAND $<TARGET_FILE:playsound> ${CMAKE_CURRENT_SOURCE_DIR}/bell.aac)
  set_tests_properties(PlaySound PROPERTIES TIMEOUT 15)
endif()

endif(f08command)

if(f18errorstop)
if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI Windows bug")
else()
  add_executable(callpython call_python_script.f90)
  target_compile_options(callpython PRIVATE ${FFLAGS})
  target_link_libraries(callpython PRIVATE osdet ${FLIBS})
endif()
endif()
