mpi = dependency('mpi', language : 'fortran')

ver = executable('mpivers', 'mpivers.f90', dependencies : mpi)
test('MPI version check', ver, is_parallel : false)

hello = executable('mpi_hello', 'helloworld.f90', dependencies : mpi)
test('MPI Hello World', hello, is_parallel : false)

# meson test --wrap "mpiexec -np 2"
pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
test('MPI thread pass', pass, is_parallel : false)

