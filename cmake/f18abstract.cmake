file(READ ${CMAKE_CURRENT_LIST_DIR}/../src/standard/abstract.f90 _code)

check_fortran_source_compiles(
"${_code}"
f18abstract
SRC_EXT f90
)
