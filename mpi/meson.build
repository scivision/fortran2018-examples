
ver = executable('mpivers', 'mpivers.f90',
  dependencies : mpi)
test('MPI version check', ver)

hello = executable('mpi_hello', 'helloworld.f90',
  dependencies : mpi)
test('MPI Hello World', mpiexec,
  timeout: 20,
  is_parallel : false,
  args: ['-np', '2', hello])


pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
test('MPI thread pass', mpiexec,
  timeout: 20,
  is_parallel : false,
  args: ['-np', '2', pass])
