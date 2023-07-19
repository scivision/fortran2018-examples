file(READ ${PROJECT_SOURCE_DIR}/test/do_concurrent/do_concurrent_reduction.f90 _code)

check_source_compiles(Fortran
"${_code}"
f202x_do_concurrent
)
