coarray = dependency('coarray', required : false)
if not coarray.found()
  subdir_done()
endif

f18coarray = fc.run('real :: x[*]; call co_sum(x); end', name: 'F2018 coarray').returncode() == 0

hello = executable('coarray_hello', 'helloworld.f90', dependencies : coarray)
test('Coarray Hello', hello)


# Intel >= 20 supports Fortran 2018 co_sum
if f18coarray
  pi = executable('coarray_pi', 'pi.f90', dependencies : coarray)
else
  pi = executable('coarray_pi', 'pi2008.f90', dependencies : coarray)
endif

test('Coarray Pi', pi)
