add_executable(ascii ascii.f90)
add_test(NAME char:AsciiSpecial COMMAND $<TARGET_FILE:ascii>)

add_executable(character_array character_array.f90)
add_test(NAME char:array COMMAND $<TARGET_FILE:character_array>)

add_executable(character_allocatable character_allocatable.f90)
add_test(NAME char:allocatable COMMAND $<TARGET_FILE:character_allocatable>)


add_executable(split split_string.f90)
add_test(NAME char:SplitString COMMAND $<TARGET_FILE:split>)

add_executable(str2int str2int.f90)
add_test(NAME char:Str2Int COMMAND $<TARGET_FILE:str2int>)


add_executable(printorwrite print_vs_write.f90)
add_test(NAME char:UTF8 COMMAND $<TARGET_FILE:printorwrite>)

add_executable(special_char special_characters.f90)
add_test(NAME char:Special COMMAND $<TARGET_FILE:special_char>)

add_executable(charlen charlen.f90)
add_test(NAME char:Len COMMAND $<TARGET_FILE:charlen>)

add_executable(overwrite_stdout overwrite_stdout.f90)
target_link_libraries(overwrite_stdout sleep_std)
add_test(NAME char:OverwriteStdout COMMAND $<TARGET_FILE:overwrite_stdout>)

add_executable(string_utils string_utils.f90 test_string.f90)
add_test(NAME char:utils COMMAND $<TARGET_FILE:string_utils>)
