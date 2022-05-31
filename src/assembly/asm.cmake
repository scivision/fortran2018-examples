set(asm_flag "-S")
# The -S option should work for GCC, Intel and Clang at least.

# there doesn't seem to be a uniform standard that allows naming output assembly
# so be sure source filenames are unique.

# need to make separate functions per language as get_source_file_properties(... LANGUAGE)
# didn't work correctly when there were no "normal" targets like add_exeuctable to compile

function(construct_asm_name name src_file)

get_filename_component(src_abs ${src_file} REALPATH)
get_filename_component(_stem ${src_file} NAME_WE)

set(asm_file ${CMAKE_CURRENT_BINARY_DIR}/${name}.s PARENT_SCOPE)
set(src_abs ${src_abs} PARENT_SCOPE)

endfunction(construct_asm_name)


function(c2asm name src_file)

construct_asm_name(${name} ${src_file})

add_custom_command(OUTPUT ${asm_file}
  COMMAND ${CMAKE_C_COMPILER} ${asm_flag} ${src_abs}
)

add_custom_target(${name} ALL DEPENDS ${asm_file})

endfunction(c2asm)


function(f2asm name src_file)

construct_asm_name(${name} ${src_file})

add_custom_command(OUTPUT ${asm_file}
  COMMAND ${CMAKE_Fortran_COMPILER} ${asm_flag} ${src_abs}
)

add_custom_target(${name} ALL DEPENDS ${asm_file})

endfunction(f2asm)
