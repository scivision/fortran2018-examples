color_exe = executable('color', 'color_text.f90')

osdet = library('osdet', 'os_detect.f90')

f08command = fc.links('integer foo; call execute_command_line(" ", exitstat=foo); end',
  name : 'F2008 execute_command_line')

if not f08command
  subdir_done()
endif

gitrev = executable('gitrev', 'gitrev.f90')
test('Git revision log', gitrev)

complog = executable('complog', 'compiler_log.f90')
test('Compiler version logging', complog)

playsound_exe = executable('playsound', 'play_sound.f90')

if f18errorstop
  callpython_exe = executable('callpython', 'call_python_script.f90',
    link_with : osdet)
endif
