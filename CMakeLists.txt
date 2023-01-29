cmake_minimum_required(VERSION 3.15...3.25)
# 3.15 for $<COMPILE_LANG_AND_ID:...>

project(Fortran2018Examples
LANGUAGES Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION 1.4.0)

enable_testing()

include(cmake/compilers.cmake)

foreach(a IN ITEMS array benchmarks block character compile contiguous debug io maximum namelist
  openacc openmp overloading pointer random real standard submodule)
  add_subdirectory(test/${a})
endforeach()

foreach(a IN ITEMS git system)
  add_subdirectory(src/${a})
endforeach()

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()
