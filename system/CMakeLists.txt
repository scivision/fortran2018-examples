cmake_minimum_required (VERSION 3.1)
project(f08exe Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(NOT f08command)
  return()
endif()

add_executable(gitrev gitrev.f90)
target_compile_options(gitrev PRIVATE ${FFLAGS})
target_link_libraries(gitrev ${FLIBS})
add_test(NAME FortranGit COMMAND gitrev)

add_executable(playsound play_sound.f90)
target_compile_options(playsound PRIVATE ${FFLAGS})
target_link_libraries(playsound ${FLIBS})
