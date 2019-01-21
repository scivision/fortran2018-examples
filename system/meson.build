osdet = library('osdet', ['os_detect.f90'])

fc = meson.get_compiler('fortran')
code = '''call execute_command_line(' '); error stop; end'''
f2008 = fc.compiles(code)

code = '''character :: b; error stop b; end'''
f2018 = fc.compiles(code)

if f2008
  complog = executable('complog', 'compiler_log.f90')
  test('Compiler version log', complog)

  sound = executable('sound', 'play_sound.f90')
  test('Play Sound', sound)
  
  gitrev = executable('gitrev', 'gitrev.f90')
  test('Git Revision', gitrev)
endif

if f2018

  callpy = executable('call_python', 'call_python_script.f90', link_with : osdet)
  test('Call Python', callpy)

endif


