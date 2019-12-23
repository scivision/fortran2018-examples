color_exe = executable('color', 'color_text.f90')
test('system: color', color_exe,
  timeout: 10)

osdet = library('osdet', 'os_detect.f90')

gitrev = executable('gitrev', 'gitrev.f90')
test('Git revision log', gitrev,
  timeout: 15)

complog = executable('complog', 'compiler_log.f90')
test('Compiler version logging', complog,
  timeout: 15)

playsound_exe = executable('playsound', 'play_sound.f90')

callpython_exe = executable('callpython', 'call_python_script.f90',
  link_with : osdet)
test('call pytohn', callpython_exe, timeout: 10)
