fc = meson.get_compiler('fortran')
cc = meson.get_compiler('c')

oldargs = fc.get_supported_arguments(['-w', '-nowarn', '/nowarn', '-std=legacy'])

if fc.get_id() == 'intel'
  add_global_arguments('-heap-arrays', language: 'fortran')
elif fc.get_id() == 'intel-cl'
  # /fpp allows #include etc preprocessor lines
  # /heap-arrays necessary to avoid segfault
   add_global_arguments('/fpp', '/heap-arrays', language: 'fortran')
endif

os = host_machine.system()

# -- compiler capabilities

f18errorstop = fc.links('character :: b; error stop b; end', name: 'F2018 error stop')
if not f18errorstop
  error('Fortran 2018 error stop is used throughout.')
endif

f03utf8 = fc.links('character(kind=selected_char_kind("ISO_10646")) :: x; end', name: 'F2003 UTF8')
# f08block = fc.links('block; end block; end', name : 'F2008 block')
f08contig = fc.links('print*,is_contiguous([0,0]); end', name: 'F2008 contiguous')
f08command = fc.links('integer foo; call execute_command_line(" ", cmdstat=foo); end', name : 'F2008 execute_command_line')
f18random = fc.links('call random_init(.false., .false.); end', name:'F2018 random_init')

code = '''
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan

if (huge(0._real128) /= 1.18973149535723176508575932662800702E+4932_real128) stop 1

end program'''
f08kind = fc.links(code, name: 'F2008 ieee kinds')
f18prop = fc.links('complex :: z; print *,z%re,z%im,z%kind; end', name: 'F2018 properties')

f18assumed_rank = fc.links(files('../array/assumed-rank.f90'), name: 'F2018 assumed rank')


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
if not fc.links(code, dependencies : mpi, name: 'Fortran MPI links')
  mpi = disabler()
endif

mpiexec = find_program('mpiexec', required : false, disabler: true)  # MS-MPI has only mpiexec

# == Intel OpenMP
mklroot = get_option('mklroot')
mkllib_root = mklroot/'lib/intel64'

intelMP_lib = []
if mklroot != ''
  n = os == 'windows' ? 'iomp5md' : 'iomp5'
  intelMP_lib = fc.find_library(n, dirs: mklroot / '../compiler/lib/intel64')
endif

# --- Lapack
if mklroot == ''
  lapack = dependency('lapack', required: false, disabler: true)
else # MKL
  lapack = []
  n1 = fc.get_id() == 'gcc' ? 'mkl_gf_lp64' : 'mkl_intel_lp64'
  names = [n1, 'mkl_intel_thread', 'mkl_core']
  foreach n : names
    lapack += fc.find_library(n, dirs: mkllib_root)
  endforeach
  lapack += intelMP_lib
endif

if not fc.links('print *,disnan(0.); end', dependencies: lapack, name: 'LAPACK')
  lapack = disabler()
endif

# -- OpenMP
openmp = dependency('openmp', language : 'fortran', required : false, disabler: true)

if not fc.links('use omp_lib; rate = omp_get_wtick(); end', name: 'OpenMP', dependencies : openmp)
  openmp = disabler()
endif
