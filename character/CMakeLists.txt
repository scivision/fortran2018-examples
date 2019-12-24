add_executable(ascii ascii.f90)
add_test(NAME AsciiSpecial COMMAND ascii)

add_executable(split split_string.f90)
add_test(NAME SplitString COMMAND split)

add_executable(str2int str2int.f90)
add_test(NAME Str2Int COMMAND str2int)


add_executable(printorwrite print_vs_write.f90)
add_test(NAME UTF8 COMMAND printorwrite)

add_executable(special_char special_characters.f90)
add_test(NAME SpecialCharacters COMMAND special_char)

add_executable(charlen charlen.f90)
add_test(NAME CharacterLen COMMAND charlen)

add_executable(overwrite_stdout overwrite_stdout.f90)
target_link_libraries(overwrite_stdout PRIVATE sleep_std)
add_test(NAME FortranOverwriteStdout COMMAND overwrite_stdout)
set_tests_properties(FortranOverwriteStdout PROPERTIES TIMEOUT 6)
