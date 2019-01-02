osdet = static_library('osdet', ['os_detect.f90'])

callpy = executable('call_python', ['call_python_script.f90'], link_with : osdet)
test('Call Python', callpy)

gitrev = executable('gitrev', 'gitrev.f90')
test('Git Revision', gitrev)

complog = executable('complog', 'compiler_log.f90')
test('Compiler version log', complog)

sound = executable('sound', 'play_sound.f90')
test('Play Sound', sound)

