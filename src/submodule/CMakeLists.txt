# We put Fortran submodules in their own Git repo because they're such an important Fortran feature.
# Here's an example of using CMake FetchContent

include(FetchContent)

FetchContent_Declare(submodules_proj
GIT_REPOSITORY https://github.com/scivision/fortran-submodule
GIT_TAG v1.3.3
TLS_VERIFY true
)

FetchContent_MakeAvailable(submodules_proj)

set_property(DIRECTORY PROPERTY LABELS submodule)

add_executable(useext use_ext.f90)
target_link_libraries(useext math_const)
add_test(NAME submodule:external COMMAND useext)
