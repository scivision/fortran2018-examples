mpi = dependency('mpi', language : 'fortran', required : false)

mpiOK = fc.run('use mpi; end', dependencies : mpi).returncode() == 0

if mpiOK
  ver = executable('mpivers', 'mpivers.f90', dependencies : mpi)
  test('MPI version check', ver)

  hello = executable('mpi_hello', 'helloworld.f90', dependencies : mpi)
  test('MPI Hello World', hello)

  mpirun = find_program('mpirun')
  pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
  test('MPI thread pass', mpirun, args: ['-np', '2', pass])
endif
