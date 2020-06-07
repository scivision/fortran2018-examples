rotflip_exe = executable('rotflip_test',
  sources: ['rot90.f90', 'test_rot90.f90'])
test('RotateFlip', rotflip_exe, timeout: 10, suite: 'array')

autoalloc_exe = executable('auto_allocate_array', 'auto_allocate.f90')
test('AutoAllocate', autoalloc_exe, timeout: 10, suite: 'array')

if f18assumed_rank
  assumed_rank_exe = executable('assumed_rank',
    sources: 'assumed-rank.f90')
  test('AssumedRank', assumed_rank_exe, timeout: 10, suite: 'array')
endif
