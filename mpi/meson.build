
ver = executable('mpivers', 'mpivers.f90',
  dependencies : mpi)
test('MPI version check', ver,
  suite: 'mpi',
  timeout: 10)

hello = executable('mpi_hello', 'helloworld.f90',
  dependencies : mpi)
test('MPI Hello World', mpiexec,
  is_parallel : false,
  args: ['-np', '2', hello],
  suite: 'mpi',
  timeout: 20)


pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
test('MPI thread pass', mpiexec,
  is_parallel : false,
  args: ['-np', '2', pass],
  suite: 'mpi',
  timeout: 20)
