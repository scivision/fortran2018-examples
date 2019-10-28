# We put Fortran submodules in their own Git repo because they're such an important Fortran feature.
# Here's an example of using CMake ExternalProject

include(ExternalProject)

ExternalProject_Add(FortranSubmodules
  GIT_REPOSITORY https://github.com/scivision/fortran-submodule
  GIT_TAG master  # it's much better to use a specific Git revision or Git tag for reproducability
  INSTALL_COMMAND ""  # this disables the install step for the external project
)

ExternalProject_Get_Property(FortranSubmodules BINARY_DIR)

add_executable(useext use_ext.f90)
add_dependencies(useext FortranSubmodules)
target_link_directories(useext PRIVATE ${BINARY_DIR})
target_link_libraries(useext PRIVATE ext)
set_target_properties(useext PROPERTIES Fortran_MODULE_DIRECTORY ${BINARY_DIR})
add_test(NAME ExternalSubmodule COMMAND useext)

# NOTES:
#
# * target_link_directories() is easier than cross-platform specifying the full path
# https://cmake.org/cmake/help/latest/command/target_link_directories.html
#
# * add_dependencies() makes external project always update and build first
#
# * In the other project called by ExternalProject, I made all the targets have
#   set_target_properties(... PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR})