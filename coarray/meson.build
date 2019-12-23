hello = executable('coarray_hello', 'helloworld.f90',
  dependencies : coarray)
test('Coarray Hello', hello,
  timeout: 20,
  suite: 'coarray',
  is_parallel : false)

if f18coarray
  pi = executable('coarray_pi', 'pi.f90',
    dependencies : coarray)

  test('Coarray Pi', pi,
    timeout: 20,
    suite: 'coarray',
    is_parallel : false)
endif
