mpi = dependency('mpi', language : 'fortran', required : false)

if not mpi.found()
  subdir_done()
endif

if not (fc.run('use mpi; end', name: 'MPI', dependencies : mpi).returncode() == 0)
  subdir_done()
endif

ver = executable('mpivers', 'mpivers.f90', dependencies : mpi)
test('MPI version check', ver)

hello = executable('mpi_hello', 'helloworld.f90', dependencies : mpi)
test('MPI Hello World', hello)

mpirun = find_program('mpiexec')  # MS-MPI has only mpiexec
pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
test('MPI thread pass', mpirun, args: ['-np', '2', pass])
