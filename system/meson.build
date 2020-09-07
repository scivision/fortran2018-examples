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

if find_program('ffplay', required: false).found()
  test('PlaySound',
    executable('playsound', 'play_sound.f90'),
    args: files('bell.aac'),
    suite: 'system',
    timeout: 15)
endif

test('call python',
executable('callpython', 'call_python_script.f90'),
suite: 'system', timeout: 15)
