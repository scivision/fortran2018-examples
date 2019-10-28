
submodule_proj = subproject('submodule')

ext_exe = executable('ext', 'use_ext.f90',
  link_with: submodule_proj.get_variable('ext_lib'))

test('submodule: external project subproject', ext_exe,
  timeout: 10)