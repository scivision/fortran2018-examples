set_directory_properties(PROPERTIES LABELS pointer)

add_executable(null_pointer null.f90)
add_test(NAME Null COMMAND null_pointer)

add_executable(derived_type derived_type.f90)
add_test(NAME DerivedType COMMAND derived_type)
