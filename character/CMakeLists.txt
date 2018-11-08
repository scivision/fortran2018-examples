cmake_minimum_required (VERSION 3.7)
project(fortran2018character Fortran)
enable_testing()


add_executable(ascii ascii.f90)
target_compile_options(ascii PRIVATE ${FFLAGS})

add_executable(split split_string.f90)
target_compile_options(split PRIVATE ${FFLAGS})
add_test(NAME Fortransplit COMMAND split)

add_executable(printorwrite print_vs_write.f90)
target_compile_options(printorwrite PRIVATE ${FFLAGS})

add_executable(str2int str2int.f90)
target_compile_options(str2int PRIVATE ${FFLAGS})

add_executable(special_char special_characters.f90)
target_compile_options(special_char PRIVATE ${FFLAGS})

add_executable(charlen charlen.f90)
target_compile_options(charlen PRIVATE ${FFLAGS})
add_test(NAME FortranCharacterLen COMMAND charlen)

add_executable(overwrite_stdout overwrite_stdout.f90)
target_compile_options(overwrite_stdout PRIVATE ${FFLAGS})
add_test(NAME FortranOverwriteStdout COMMAND overwrite_stdout)
set_tests_properties(FortranOverwriteStdout PROPERTIES TIMEOUT 6)


