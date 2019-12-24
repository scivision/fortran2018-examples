
# --- Scalapack
scalapack = dependency('scalapack', cmake_module_path : 'cmake/Modules', required: false, disabler: true)

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

blacs1_exe = executable('blacs1', 'blacs.f',
  dependencies: [mpi, lapack, scalapack])
test('BLACS', mpiexec,
  args: ['-np', '1', blacs1_exe],
  suite: 'mumps',
  timeout: 10)

scalapack_exe = executable('scalapack_demo', 'scalapack_demo.f90',
  dependencies: [mpi, lapack, scalapack])
test('Scalapack', scalapack_exe,
  suite: 'mumps',
  timeout: 15)

testmumps_exe = executable('testmumps', 'test_mumps.f90',
  dependencies: [mpi, mumps])
test('MUMPS', mpiexec,
  args: ['-np', '1', testmumps_exe, files('input_simpletest_real')],
  suite: 'mumps',
  timeout: 15)
