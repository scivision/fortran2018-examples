rotflip = library('rotflip', 'rot90.f90')

rotflip_test = executable('rotflip_test', 'test_rot90.f90',
  link_with : rotflip)
test('Rotate Flip', rotflip_test,
  timeout: 10)
