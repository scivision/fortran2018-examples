color_exe = executable('color', 'color_text.f90')

osdet = library('osdet', 'os_detect.f90')

fc = meson.get_compiler('fortran')
f08command = fc.links('call execute_command_line(" "); end',
  name : 'F2008 execute_command_line')

if f08command
  gitrev = executable('gitrev', 'gitrev.f90')
  test('Git revision log', gitrev)
  
  complog = executable('complog', 'compiler_log.f90')
  test('Compiler version logging', complog)
  
  playsound_exe = executable('playsound', 'play_sound.f90')
endif

f18errorstop = fc.compiles('error stop; end', name: 'F2018 error stop')
if f18errorstop
  callpython_exe = executable('callpython', 'call_python_script.f90',
    link_with : osdet)
endif
