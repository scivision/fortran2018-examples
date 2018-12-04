cmake_minimum_required(VERSION 3.7)
project(std Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

add_executable(shortcircuit short_circuit.f90)
target_compile_options(shortcircuit PRIVATE ${FFLAGS})
target_link_libraries(shortcircuit ${FLIBS})

add_executable(bitpat bitpat.f90)
target_compile_options(bitpat PRIVATE ${FFLAGS})
target_link_libraries(bitpat ${FLIBS})
add_test(NAME FortranBitPattern COMMAND bitpat)


add_executable(justwait replace_pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
target_link_libraries(justwait ${FLIBS})
#add_test(NAME FortranWait COMMAND justwait)

add_executable(sleepstd sleep_std.f90)
target_compile_options(sleepstd PRIVATE ${FFLAGS})
target_link_libraries(sleepstd ${FLIBS})
add_test(NAME FortranMicrosleep COMMAND sleepstd)
set_tests_properties(FortranMicrosleep PROPERTIES TIMEOUT 1)

add_executable(statement statement_function.f90)
target_compile_options(statement PRIVATE ${FFLAGS})
target_link_libraries(statement ${FLIBS})
add_test(NAME Statement COMMAND statement)

