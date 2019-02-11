
coarray = dependency('coarray', required : false)

f08coarray = fc.links('real :: x[*]; end')
f18coarray = fc.run('real :: x[*]; call co_sum(x); end').returncode() == 0

if f08coarray
  hello = executable('coarray_hello', 'helloworld.f90', dependencies : coarray)
  test('Coarray Hello', hello)
endif


if f18coarray
  pi = executable('coarray_pi', 'pi.f90', dependencies : coarray)
elif f08coarray
  # Intel 2018 does not yet support Fortran 2018 co_sum
  pi = executable('coarray_pi', 'pi2008.f90', dependencies : coarray)
endif

if f08coarray
test('Coarray Pi', pi)
endif
