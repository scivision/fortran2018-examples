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

notermsize = executable('notermsize', 'noenv.f90')
test('NoTermSize', notermsize)

readonly = executable('readonly', 'fileopen-readonly.f90')
test('ReadOnly', readonly,
  timeout: 10, suite: 'io')

if not(os == 'windows' and fc.get_id() == 'pgi')
  null = executable('null', 'devnull.f90')
  test('Nullfile', null,
    timeout: 10, suite: 'io')
endif

pathlib = library('pathlib', 'pathlib.F90')
test_pathlib = executable('test_pathlib',
  sources: 'test_pathlib.f90',
  link_with: pathlib)
test('mkdirSimple', test_pathlib,
  args: meson.current_build_dir() / 'testdir/hello',
  suite: 'io',
  timeout: 20)
test('mkdirTrailingSep', test_pathlib,
  args: meson.current_build_dir() / 'testdir/hello/',
  suite: 'io',
  timeout: 20)

# has to be run() test for detecting defective system realpath()
if os == 'windows'
  code = '''
#include <stdlib.h>
#include <string.h>
int main(void) {
char resolved_path[_MAX_PATH];
_fullpath(resolved_path, "..", _MAX_PATH);
if(strcmp("..", resolved_path) == 0 || strcmp(".", resolved_path) == 0) return 1;
return 0; }
'''
  if (cc.run(code, name: 'Windows _fullpath').returncode() == 0)
    fullpath = executable('fullpath', 'fullpath_windows.f90')
    test('fullpath', fullpath, timeout: 10, suite: 'io')
  endif
elif os != 'darwin'  # FIXME: make test in Fortran not C
  code = '''
#include <limits.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
char resolved_path[PATH_MAX];
realpath("..", resolved_path);
if(strcmp("..", resolved_path) == 0 || strcmp(".", resolved_path) == 0) return 1;
return 0; }
'''
  if (cc.run(code, name: 'POSIXrealpath').returncode() == 0)
    realpath = executable('realpath', 'realpath_posix.f90')
    test('realpath', realpath, timeout: 10, suite: 'io')
  endif
endif

if add_languages('cpp', required: false)
  cpp = meson.get_compiler('cpp')
  # some compilers will compile and link, but only fail on run when accessing
  # the actual filesystem paths
  # e.g. MinGW G++ 9.2.0
  cpp17filesystem_ok = cpp.run(files('cxx17filesystem.cxx'), name: 'C++ filesystem').returncode() == 0
  if cpp17filesystem_ok and fc.get_id() != 'intel-cl'
  # Meson has a bug with Intel 2020 linking c++17
  # error LNK2019: unresolved external symbol wmemcmp referenced in function "enum __std_win_error __cdecl std::filesystem::_Canonical
    canonical_lib = library('canonical', 'canonical.cxx')
    canonical_cxx_exe = executable('canonical_cxx', 'canonical_demo.cxx', link_with: canonical_lib)
    test('canonicalC++', canonical_cxx_exe, timeout: 10, suite: 'io')

    # FIXME: Intel 2020 has bugs, will it work for GCC 10 or LLVM 10?
    # canonical_fortran_exe = executable('canonical_fortran', 'realpath_cxx.f90', link_with: canonical_lib)
    # test('canonicalFortran', canonical_fortran_exe, timeout: 10, suite: 'io')
  endif
endif
