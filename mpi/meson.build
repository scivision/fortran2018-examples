mpi = dependency('mpi', language : 'fortran', required : false)

if not mpi.found()
  subdir_done()
endif

mpiOK = fc.run('use mpi; end', dependencies : mpi).returncode() == 0

if mpiOK
  ver = executable('mpivers', 'mpivers.f90', dependencies : mpi)
  test('MPI version check', ver)

  hello = executable('mpi_hello', 'helloworld.f90', dependencies : mpi)
  test('MPI Hello World', hello)

  mpirun = find_program('mpiexec')  # MS-MPI has only mpiexec, not mpirun
  pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
  test('MPI thread pass', mpirun, args: ['-np', '2', pass])
endif
