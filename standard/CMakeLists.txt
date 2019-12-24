
add_executable(shortcircuit short_circuit.f90)
# shaky result, don't CI test

add_executable(bitpat bitpat.f90)
add_test(NAME BitPattern COMMAND bitpat)

add_executable(justwait pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
target_link_libraries(justwait ${FLIBS})
# NO test

add_executable(mkdirstd mkdir.f90)
if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  target_sources(mkdirstd PRIVATE isdir_intel.f90)
else()
  target_sources(mkdirstd PRIVATE isdir.f90)
endif()
add_test(NAME mkdir COMMAND $<TARGET_FILE:mkdirstd> testdir/hello)


add_library(sleep_std sleep_std.F90)
set_target_properties(sleep_std PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR})

add_executable(sleep_demo sleep_demo.f90)
target_link_libraries(sleep_demo PRIVATE sleep_std)
add_test(NAME StandardSleep COMMAND sleep_demo)
set_tests_properties(StandardSleep PROPERTIES TIMEOUT 5)

add_executable(statement statement_function.f90)
add_test(NAME Statement COMMAND statement)

