# We put Fortran submodules in their own Git repo because they're such an important Fortran feature.
# Here's an example of using CMake FetchContent

include(FetchContent)

FetchContent_Declare(FortranSubmodules
  GIT_REPOSITORY https://github.com/scivision/fortran-submodule
  GIT_TAG master  # it's much better to use a specific Git revision or Git tag for reproducability
)

FetchContent_MakeAvailable(FortranSubmodules)

add_executable(useext use_ext.f90)
target_link_libraries(useext PRIVATE ext)
add_test(NAME ExternalSubmodule COMMAND $<TARGET_FILE:useext>)
