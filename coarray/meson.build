project('Fortran Coarray', 'fortran', default_options : ['default_library=static'])
# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.
# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

coarray = dependency('Coarray')

fc = meson.get_compiler('fortran')
f18coarray = fc.run('real :: x[*]; call co_sum(x); end').returncode() == 0

hello = executable('coarray_hello', 'helloworld.f90', dependencies : coarray)
  
test('Coarray Hello', hello)

if f18coarray
  pi = executable('coarray_pi', 'pi.f90', dependencies : coarray)
else
  # Intel 2018 does not yet support Fortran 2018 co_sum
  pi = executable('coarray_pi', 'pi2008.f90', dependencies : coarray)
endif

test('Coarray Pi', pi)
