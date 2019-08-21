mpi = dependency('mpi', language : 'fortran', required : false)

if not mpi.found()
  subdir_done()
endif

if fc.links('''
    use mpi
    integer :: i
    call mpi_init(i)
    call mpi_finalize(i)
    end''',
    dependencies : mpi,
    name: 'Fortran MPI links')
  subdir_done()
endif

mpiexec = find_program('mpiexec')  # MS-MPI has only mpiexec

ver = executable('mpivers', 'mpivers.f90',
  dependencies : mpi)
test('MPI version check', ver)

hello = executable('mpi_hello', 'helloworld.f90',
  dependencies : mpi)
test('MPI Hello World', mpiexec,
  args: ['-np', '2', hello])


pass = executable('mpi_pass', 'thread_pass.f90', dependencies : mpi)
test('MPI thread pass', mpiexec,
  args: ['-np', '2', pass])
