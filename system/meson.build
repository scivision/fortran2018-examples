color_exe = executable('color', 'color_text.f90')
test('color', color_exe,
  suite: 'system',
  timeout: 10)

osdet = library('osdet', 'os_detect.f90')

gitrev = executable('gitrev', 'gitrev.f90')
test('Git revision log', gitrev,
  suite: 'system',
  timeout: 15)

complog = executable('complog', 'compiler_log.f90')
test('Compiler version logging', complog,
  suite: 'system',
  timeout: 15)

playsound_exe = executable('playsound', 'play_sound.f90')
if find_program('ffplay', required: false).found()
  test('PlaySound', playsound_exe,
    args: files('bell.aac'),
    suite: 'system',
    timeout: 15)
endif

if run_command(['python', '-c', 'import psutil']).returncode() == 0
  callpython_exe = executable('callpython', 'call_python_script.f90',
    link_with : osdet)
  test('call python', callpython_exe,
    suite: 'system',
    timeout: 10)
endif