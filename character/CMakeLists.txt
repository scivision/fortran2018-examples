cmake_minimum_required (VERSION 3.7)
project(fortran2018character Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

add_executable(ascii ascii.f90)
target_compile_options(ascii PRIVATE ${FFLAGS})
target_link_libraries(ascii ${FLIBS})

add_executable(split split_string.f90)
target_compile_options(split PRIVATE ${FFLAGS})
target_link_libraries(split ${FLIBS})
add_test(NAME Fortransplit COMMAND split)

add_executable(printorwrite print_vs_write.f90)
target_compile_options(printorwrite PRIVATE ${FFLAGS})
target_link_libraries(printorwrite ${FLIBS})

add_executable(str2int str2int.f90)
target_compile_options(str2int PRIVATE ${FFLAGS})
target_link_libraries(str2int ${FLIBS})

add_executable(special_char special_characters.f90)
target_compile_options(special_char PRIVATE ${FFLAGS})
target_link_libraries(special_char ${FLIBS})

add_executable(charlen charlen.f90)
target_compile_options(charlen PRIVATE ${FFLAGS})
target_link_libraries(charlen ${FLIBS})
add_test(NAME FortranCharacterLen COMMAND charlen)

if(NOT WIN32)
add_executable(overwrite_stdout overwrite_stdout.f90)
target_compile_options(overwrite_stdout PRIVATE ${FFLAGS})
target_link_libraries(overwrite_stdout ${FLIBS})
add_test(NAME FortranOverwriteStdout COMMAND overwrite_stdout)
set_tests_properties(FortranOverwriteStdout PROPERTIES TIMEOUT 6)
endif()

