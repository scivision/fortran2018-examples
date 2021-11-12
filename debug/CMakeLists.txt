set_directory_properties(PROPERTIES LABELS debug)

add_executable(bad_alloc badalloc.f90)

add_executable(badbounds badbounds.f90)
target_compile_options(badbounds PRIVATE $<$<Fortran_COMPILER_ID:GNU>:-fcheck=bounds>)
