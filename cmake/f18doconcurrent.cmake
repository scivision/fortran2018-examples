file(READ ${PROJECT_SOURCE_DIR}/test/standard/do_concurrent_reduction.f90 _code)

check_source_compiles(Fortran
"${_code}"
f18doconcurrent
)
