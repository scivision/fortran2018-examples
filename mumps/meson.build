
mpi = dependency('MPI', language: 'fortran', required: false)
if not mpi.found()
  message('MUMPS skipped due to missing MPI')
  subdir_done()
endif
# --- Metis
# Default is PORD instead of METIS.
# find_package(METIS)
# if(METIS_FOUND)
# add_executable(metis1 metis.f90)
# target_compile_options(metis1 PRIVATE ${FFLAGS})
# target_link_libraries(metis1 PRIVATE ${METIS_LIBRARIES})
# target_include_directories(metis1 PRIVATE ${METIS_INCLUDE_DIRS})
# add_test(NAME Metis
# COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} $<TARGET_FILE:metis1>
# WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
# endif()
# --- Lapack
# Lapack must work correctly for Scalapack to work
lapack = dependency('lapack', required: false)
if not lapack.found()
  message('MUMPS skipped due to missing Lapack')
  subdir_done()
endif
# --- Scalapack
# Scalapack must work correctly for MUMPS to work
scalapack = dependency('scalapack', required: false)
if not scalapack.found()
  message('MUMPS skipped due to missing Scalapack')
  subdir_done()
endif

blacs1_exe = executable('blacs1', 'blacs.f', dependencies: [mpi, lapack, scalapack])
test('BLACS', mpiexec_executable,
  args: ['-np', '1', blacs1_exe],
  timeout: 10)

scalapack1_exe = executable('scalapack1', 'scalapack_example1.f', dependencies: [mpi, lapack, scalapack])
# note: this test needs at least 6 MPI processes, even if you're on a very small computer it's OK.
test('Scalapack', mpiexec_executable,
  args: ['-np', '6', '--oversubscribe', scalapack1_exe],
  workdir: meson.current_source_dir(),
  timeout: 15)

# --- MUMPS
mumps = dependency('mumps', required: false)
if not mumps.found()
  message('MUMPS skipped')
  subdir_done()
endif

testmumps_exe = executable('testmumps', 'test_mumps.f90', dependencies: [mpi, mumps])
test('MUMPS', mpiexec_executable,
  args: ['-np', '1', testmumps_exe],
  workdir: meson.current_source_dir(),
  timeout: 15)
