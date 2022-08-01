set_property(DIRECTORY PROPERTY LABELS block)

add_executable(block block.f90)
add_test(NAME block:Block COMMAND block)
