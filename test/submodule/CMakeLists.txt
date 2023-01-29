set_property(DIRECTORY PROPERTY LABELS submodule)

add_executable(explicit explicit.f90)
add_test(NAME submodule_explicit COMMAND explicit)

add_executable(sm_proc procedure.f90)
add_test(NAME submodule_procedure COMMAND sm_proc)
