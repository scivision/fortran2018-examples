
# --- Scalapack
scalapack = dependency('scalapack', cmake_module_path : 'cmake/Modules', required: false, disabler: true)
if not scalapack.found()
  scalapack = fc.find_library('scalapack-openmpi', required: false, disabler: true)
endif
if not scalapack.found()
  scalapack = fc.find_library('scalapack', required: false, disabler: true)
endif

# --- MUMPS
# mumps = dependency('mumps', required: false, disabler: true)
if os == 'linux'
  mumpsinc = '/usr/include'
else
  mumpsinc = ''
endif
mumpslib = fc.find_library('dmumps', required : false, disabler: true)
mumps = declare_dependency(include_directories: mumpsinc, dependencies: mumpslib)

# --- code

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

testmumps_exe = executable('testmumps', 'test_mumps.f90', dependencies: [mpi, mumps])
test('MUMPS', mpiexec,
  args: ['-np', '1', testmumps_exe],
  workdir: meson.current_source_dir(),
  timeout: 15)
