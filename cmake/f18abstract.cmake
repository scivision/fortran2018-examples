file(READ ${PROJECT_SOURCE_DIR}/test/standard/abstract.f90 _code)

check_source_compiles(Fortran
"${_code}"
f18abstract
)
