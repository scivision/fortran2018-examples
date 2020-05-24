conf_data = configuration_data()

if mklroot == ''
  conf_data.set('lapack95_use', 'use f95_lapack, only: gesvd=>la_gesvd')
  lapack95 = fc.find_library('lapack95', required: false, disabler: true)
  if not fc.links('use f95_lapack, only: gesvd=>la_gesvd; end', dependencies: [lapack95, lapack], name: 'LAPACK95')
    lapack95 = disabler()
  endif
else
  conf_data.set('lapack95_use', 'use lapack95, only: gesvd')
  incdir = include_directories(mklroot / 'include/intel64/lp64')
  lapack95_lib = [fc.find_library('mkl_blas95_lp64', required: false, disabler: true),
                  fc.find_library('mkl_lapack95_lp64', required: false, disabler: true)]
  if fc.links('use lapack95, only: gesvd; end', dependencies: [lapack95_lib, lapack], include_directories: incdir, name: 'LAPACK95')
    lapack95 = declare_dependency(dependencies: [lapack95_lib, lapack], include_directories: incdir)
  else
    lapack95 = disabler()
  endif
endif


configure_file(input : 'demo_gesvd.in.f90',
               output : 'demo_gesvd.f90',
               configuration : conf_data)

svd95_exe = executable('lapack95_svd_demo',
  sources: [meson.current_build_dir() / 'demo_gesvd.f90'],
  dependencies: lapack95)
test('Lapack95SVD', svd95_exe,
  suite: 'lapack95',
  timeout: 10)

#=== LAPACK MKL example with Intel OR Gfortran compilers ===

dsvd_exe = executable('dsvd_demo', 'intel_dgesvd.f90',
  dependencies: lapack)
test('LapackSVD', dsvd_exe,
  suite: 'lapack95',
  timeout: 10)
