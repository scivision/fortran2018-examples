cmake_minimum_required(VERSION 3.3)
project(fortran2018demo Fortran C CXX)
enable_testing()

option(USE_MKL "Use Intel MKL" OFF)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules/)

include(cmake/compilers.cmake)


add_subdirectory(array)
add_subdirectory(benchmarks)
add_subdirectory(character)
add_subdirectory(coarray)
add_subdirectory(contiguous)
add_subdirectory(cxx)
add_subdirectory(hdf5)
add_subdirectory(io)
add_subdirectory(mpi)
add_subdirectory(netcdf)
add_subdirectory(openmp)
add_subdirectory(overloading)
add_subdirectory(random)
add_subdirectory(real)
add_subdirectory(submodule)
add_subdirectory(system)


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

add_executable(bitpat bitpat.f90)
target_compile_options(bitpat PRIVATE ${FFLAGS})
target_link_libraries(bitpat ${FLIBS})
add_test(NAME FortranBitPattern COMMAND bitpat)


