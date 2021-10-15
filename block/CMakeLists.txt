set_directory_properties(PROPERTIES LABELS block)

add_executable(block block.f90)
add_test(NAME block:Block COMMAND $<TARGET_FILE:block>)
