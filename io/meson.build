logging_lib = library('logging', 'logging.f90')

termio = executable('termio', 'terminal_io.f90')

leading_zeros = executable('leading_zeros', 'leading_zeros.f90')
test('LeadingZeros', leading_zeros,
  timeout: 10, suite: 'io')

notermsize = executable('notermsize', 'noenv.f90')
test('NoTermSize', notermsize)

null = executable('null', 'devnull.f90')
test('Nullfile', null, timeout: 10, suite: 'io')


# --- pathlib
conf_data = configuration_data()
pathlib_src = os == 'windows' ? files('pathlib_windows.f90') : files('pathlib_unix.f90')
if ['intel', 'intel-cl'].contains(fc.get_id())
  conf_data.set('dir_exist', 'inquire(directory=path, exist=exists)')
else
  conf_data.set('dir_exist', 'inquire(file=path, exist=exists)')
endif
configure_file(input : 'pathlib.in.f90',
               output : 'pathlib.f90',
               configuration : conf_data)

pathlib = library('pathlib',
  sources: [meson.current_build_dir() / 'pathlib.f90', pathlib_src])
test_pathlib = executable('test_pathlib', 'test_pathlib.f90', link_with: pathlib)
test('pathlib', test_pathlib, suite: 'io', timeout: 20)


readonly = executable('readonly', 'fileopen-readonly.f90', link_with: pathlib)
test('ReadOnly', readonly, timeout: 10, suite: 'io')

append_exe = executable('test_logging', 'append_file.f90',
  link_with : [logging_lib, pathlib])

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
    # test('realpath', realpath, timeout: 10, suite: 'io')
  endif
endif
