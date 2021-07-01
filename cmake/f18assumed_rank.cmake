file(READ ${CMAKE_CURRENT_LIST_DIR}/../array/assumed-rank.f90 _code)

check_source_compiles(Fortran
"${_code}"
f18assumed_rank)
