fc = meson.get_compiler('fortran')
f18flag = fc.first_supported_argument(['-std=f2018', '-stand f18', '/stand:f18'])
impnone = fc.first_supported_argument(['-fimplicit-none', '-warn declarations', '/warn:declarations', '-Mdclchk'])
oldargs = fc.first_supported_argument(['-w', '-nowarn', '/nowarn'])

if fc.get_id() == 'gcc'
  add_global_arguments('-Wextra', '-Wpedantic', f18flag, impnone, language : 'fortran')
  oldargs += '-std=legacy'
elif fc.get_id() == 'intel'
  add_global_arguments(f18flag, impnone, '-heap-arrays', language: 'fortran')
elif fc.get_id() == 'intel-cl'
  # /fpp allows #include etc preprocessor lines
  # /heap-arrays necessary to avoid segfault
   add_global_arguments(f18flag, impnone, '/fpp', '/heap-arrays', language: 'fortran')
elif fc.get_id() == 'pgi'
   add_global_arguments('-C', impnone, language: 'fortran')
elif fc.get_id() == 'flang'
  add_global_arguments('-W', language: 'fortran')
endif

os = host_machine.system()

# -- compiler capabilities

f18errorstop = fc.links('character :: b; error stop b; end', name: 'F2018 error stop')
f08block = fc.links('block; end block; end', name : 'F2008 block')
f08contig = fc.links('contig = is_contiguous([1,2,3]); end', name: 'F2008 contiguous')
f08command = fc.links('integer foo; call execute_command_line(" ", exitstat=foo); end', name : 'F2008 execute_command_line')
f18random = fc.links('call random_init(.false., .false.); end', name:'F2018 random_init')

code = '''
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan

if (huge(0._real128) /= 1.18973149535723176508575932662800702E+4932_real128) stop 1

end program'''
f08kind = fc.links(code, name: 'F2008 ieee kinds')
f18prop = fc.links('complex :: z; print *,z%re,z%im,z%kind; end', name: 'F2018 properties')
# -- Fortran coarray

coarray = dependency('coarray', required : false, disabler: true)
# must be "run" in case of broken MPI library that only shows up on run.
if not (fc.run('sync all; end', dependencies: coarray, name:'Coarray').returncode() == 0)
  coarray = disabler()
endif

f18coarray = fc.run('real :: x[*]; call co_sum(x); sync all; end', dependencies: coarray, name: 'F2018 coarray').returncode() == 0


# -- MPI

mpi = dependency('mpi', language : 'fortran', required : false, disabler: true)
code = '''
use mpi
integer :: i
call mpi_init(i)
call mpi_finalize(i)
end program'''
if mpi.found() and not fc.links(code, dependencies : mpi, name: 'Fortran MPI links')
  mpi = disabler()
endif

mpiexec = find_program('mpiexec', required : false, disabler: true)  # MS-MPI has only mpiexec

# -- HDF5

hdf5 = dependency('hdf5', language : 'fortran', required : false, disabler: true)

if hdf5.found() and not fc.links('use h5lt; end', name: 'HDF5', dependencies : hdf5)
  hdf5 = disabler()
endif

# -- NetCDF
# apt install libnetcdf-dev libnetcdff-dev     # need BOTH installed

# when using CMake, need to capitalize module name like in CMake
netcdf = dependency('NetCDF', required : false, disabler: true,
  cmake_module_path : meson.source_root() / 'cmake/Modules')

if netcdf.found() and not fc.links('use netcdf; end', name: 'NetCDF', dependencies : netcdf)
  netcdf = disabler()
endif

# --- Lapack
lapack = dependency('lapack', required: false, disabler: true)

# --- Scalapack
# dependency('scalapack') not yet working in Meson
# scalapack = dependency('scalapack', cmake_module_path : 'cmake/Modules', required: false, disabler: true)
scalapack = fc.find_library('scalapack-openmpi', required: false, disabler: true)
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

# -- OpenMP
openmp = dependency('openmp', language : 'fortran', required : false, disabler: true)

if openmp.found() and not fc.links('use omp_lib; rate = omp_get_wtick(); end', name: 'OpenMP', dependencies : openmp)
  openmp = disabler()
endif