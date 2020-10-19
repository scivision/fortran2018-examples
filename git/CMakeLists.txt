find_package(Git)

set(_max_len 80) # arbitrary limit, so as not to exceed maximum 132 character Fortran line length.

set(git_version ${GIT_VERSION_STRING})
string(SUBSTRING ${git_version} 0 ${_max_len} git_version)
if(GIT_FOUND)

# git branch --show-current requires Git >= 2.22, June 2019
execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
OUTPUT_VARIABLE git_branch OUTPUT_STRIP_TRAILING_WHITESPACE)
string(SUBSTRING ${git_branch} 0 ${_max_len} git_branch)

execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
OUTPUT_VARIABLE git_rev OUTPUT_STRIP_TRAILING_WHITESPACE)
string(SUBSTRING ${git_rev} 0 ${_max_len} git_rev)

set(git_porcelain .true.)
execute_process(COMMAND ${GIT_EXECUTABLE} status --porcelain
OUTPUT_VARIABLE _porcelain OUTPUT_STRIP_TRAILING_WHITESPACE)
if(_porcelain)
  set(git_porcelain .false.)
endif(_porcelain)
else()
set(git_branch)
set(git_rev)
set(git_porcelain .false.)
endif()

message(STATUS "${PROJECT_NAME}  git revision: ${git_rev}  git_branch: ${git_branch}  git_porcelain: ${git_porcelain}")

# example
configure_file(main.in.f90 main.f90)
add_executable(git_rev ${CMAKE_CURRENT_BINARY_DIR}/main.f90)
add_test(NAME git:revision COMMAND $<TARGET_FILE:git_rev>)
