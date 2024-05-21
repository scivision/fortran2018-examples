check_source_compiles(Fortran
"program test
call random_init(.false., .false.)
end program"
f18random
)

if(NOT f18random)
  return()
endif()

file(READ ${PROJECT_SOURCE_DIR}/test/standard/random_init.f90 _s)

check_source_runs(Fortran ${_s} f18random_init)
