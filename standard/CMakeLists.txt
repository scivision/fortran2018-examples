
if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "shortcircuit: PGI Windows bug")
else()
  add_executable(shortcircuit short_circuit.f90)
  add_test(NAME ShortCircuit COMMAND shortcircuit)
endif()

add_executable(bitpat bitpat.f90)
add_test(NAME BitPattern COMMAND bitpat)


add_executable(justwait pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
target_link_libraries(justwait ${FLIBS})
# NO test

if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "mkdir: PGI Windows bug")
else()
  add_executable(mkdirstd mkdir.f90)
  if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
    target_sources(mkdirstd PRIVATE isdir_intel.f90)
  else()
    target_sources(mkdirstd PRIVATE isdir.f90)
  endif()
  set(_dirlist testdir/hello a/b a/b/c/)
  foreach(_dir ${_dirlist})
    file(REMOVE_RECURSE ${_dir})
    add_test(NAME mkdir_${_dir} COMMAND $<TARGET_FILE:mkdirstd> ${_dir})
  endforeach()
endif()


add_library(sleep_std sleep_std.F90)

add_executable(sleep_demo sleep_demo.f90)
target_link_libraries(sleep_demo PRIVATE sleep_std
add_test(NAME StandardSleep COMMAND sleep_demo)
set_tests_properties(StandardSleep PROPERTIES TIMEOUT 5)

add_executable(statement statement_function.f90)
add_test(NAME Statement COMMAND statement)

