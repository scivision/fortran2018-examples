set_directory_properties(PROPERTIES LABELS io)

add_library(logging OBJECT logging.f90)

add_executable(append_file append_file.f90)
target_link_libraries(append_file PRIVATE logging pathlib)
add_test(NAME io:appendFile COMMAND append_file)

add_executable(termio terminal_io.f90)
add_test(NAME io:terminal COMMAND bash -c "$<TARGET_FILE:termio> <<< 0")
set_tests_properties(io:terminal PROPERTIES DISABLED $<BOOL:${WIN32}>
)

add_executable(leading_zeros leading_zeros.f90)
add_test(NAME io:leading_zeros COMMAND leading_zeros)
set_tests_properties(io:leading_zeros PROPERTIES
  PASS_REGULAR_EXPRESSION "hello1234.5600000")

add_executable(notermsize noenv.f90)
add_test(NAME io:NoTermSize COMMAND notermsize)

add_executable(readonly fileopen-readonly.f90)
target_link_libraries(readonly pathlib)
add_test(NAME io:ReadOnly COMMAND readonly)

add_executable(null devnull.f90)
add_test(NAME io:nullfile COMMAND null)

# --- pathlib
add_library(pathlib OBJECT pathlib.f90
$<IF:$<BOOL:${WIN32}>,pathlib_windows.f90,pathlib_unix.f90>
$<IF:$<Fortran_COMPILER_ID:Intel,IntelLLVM>,pathlib_intel.f90,pathlib_gcc.f90>
)

add_executable(test_pathlib test_pathlib.f90)
target_link_libraries(test_pathlib pathlib)
add_test(NAME io:pathlib COMMAND $<TARGET_FILE:test_pathlib>)

# future, when c++17 filesystem is better supported in general.
# add_executable(realpath $<IF:$<BOOL:${posixio_OK}>,realpath_posix.f90,fullpath_windows.f90>)
