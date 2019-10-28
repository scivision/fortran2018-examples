
mpi = dependency('MPI', language: 'fortran', required: false, disabler: true)
if not fc.links('use mpi; end', dependencies: mpi, name: 'MPI')
  mpi = disabler()
endif
mpiexec = find_program('mpiexec', required: false, disabler: true)

# --- Lapack
# Lapack must work correctly for Scalapack to work
lapack = dependency('lapack', required: false, disabler: true)

# --- Scalapack
# dependency('scalapack') not yet working in Meson--cmake->meson bug within Meson, yielding long meson-log.txt
# scalapack = dependency('scalapack', cmake_module_path : 'cmake/Modules')
scalapack = fc.find_library('scalapack-openmpi', required: false, disabler: true)
if not scalapack.found()
  scalapack = fc.find_library('scalapack', required: false, disabler: true)
endif

blacs1_exe = executable('blacs1', 'blacs.f', dependencies: [mpi, lapack, scalapack])
test('BLACS', mpiexec,
  args: ['-np', '1', blacs1_exe],
  timeout: 10)

scalapack1_exe = executable('scalapack1', 'scalapack_example1.f',
  dependencies: [mpi, lapack, scalapack])
# note: this test needs at least 6 MPI processes, even if you're on a very small computer it's OK.
test('Scalapack', mpiexec,
  args: ['-np', '6', '--oversubscribe', scalapack1_exe],
  workdir: meson.current_source_dir(),
  timeout: 15)

# --- MUMPS
# mumps = dependency('mumps', required: false)
if os == 'linux'
  mumpsinc = '/usr/include'
else
  mumpsinc = ''
endif
mumpslib = fc.find_library('dmumps', required : false, disabler: true)
mumps = declare_dependency(include_directories: mumpsinc, dependencies: mumpslib)

testmumps_exe = executable('testmumps', 'test_mumps.f90', dependencies: [mpi, mumps])
test('MUMPS', mpiexec,
  args: ['-np', '1', testmumps_exe],
  workdir: meson.current_source_dir(),
  timeout: 15)
