file(READ ${PROJECT_SOURCE_DIR}/test/standard/abstract.f90 _code)

check_fortran_source_compiles(
"${_code}"
f18abstract
SRC_EXT f90
)
