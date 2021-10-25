add_executable(badbounds badbounds.f90)
target_compile_options(badbounds PRIVATE $<$<Fortran_COMPILER_ID:GNU>:-fcheck=bounds>)

add_executable(nanmaxmin maxmin_nan.f90)
add_test(NAME debug:NaNminmax COMMAND nanmaxmin)
