
hello = executable('coarray_hello', 'helloworld.f90',
  dependencies : coarray)
test('Coarray Hello', hello,
  timeout: 20,
  is_parallel : false)

pi_src = f18coarray ?  'pi.f90' : 'pi2008.f90'

pi = executable('coarray_pi', pi_src,
  dependencies : coarray)

test('Coarray Pi', pi,
  timeout: 20,
  is_parallel : false)
