logging_lib = library('logging', 'logging.f90')
append_exe = executable('test_logging', 'append_file.f90',
  link_with : logging_lib)

termio = executable('termio', 'terminal_io.f90')

leading_zeros = executable('leading_zeros', 'leading_zeros.f90')
test('LeadingZeros', leading_zeros,
  timeout: 10, suite: 'io')

expanduser = executable('expanduser', 'expanduser.f90')
test('expanduser', expanduser,
  args: ['~'],
  timeout: 10, suite: 'io')

if os == 'linux'
  realpath = executable('realpath', 'realpath_linux.f90')
  test('realpath', realpath, timeout: 10, suite: 'io')
endif

if add_languages('cpp', required: false)
  cpp = meson.get_compiler('cpp')
  code = '''
  #include <filesystem>
  namespace fs = std::filesystem;

  int main(void) {
  fs::path p = fs::path(".");
  return 0; }
  '''
  # some compilers will compile and link, but only fail on run when accessing
  # the actual filesystem paths
  # e.g. MinGW G++ 9.2.0
  cpp17filesystem_ok = cpp.run(code, name: 'C++ filesystem').returncode() == 0
  if cpp17filesystem_ok
    canonical_lib = library('canonical', 'canonical.cxx')
    canonical_cxx_exe = executable('canonical_cxx', 'canonical_demo.cxx', link_with: canonical_lib)
    test('canonicalC++', canonical_cxx_exe, timeout: 10, suite: 'io')

    # TODO: see if this is feasible with GCC 10 / Intel 20.0
    # canonical_fortran_exe = executable('canonical_fortran', 'realpath_cxx.f90', link_with: canonical_lib)
    # test('canonicalFortran', canonical_fortran_exe, timeout: 10, suite: 'io')
  endif
endif

notermsize = executable('notermsize', 'noenv.f90')
test('NoTermSize', notermsize)
if f18errorstop
  readonly = executable('readonly', 'fileopen-readonly.f90')
  test('ReadOnly', readonly, timeout: 10, suite: 'io')

  if not(os == 'windows' and fc.get_id() == 'pgi')
    null = executable('null', 'devnull.f90')
    test('Nullfile', null, timeout: 10, suite: 'io')
  endif
endif
