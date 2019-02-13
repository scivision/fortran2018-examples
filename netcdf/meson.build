# apt install libnetcdf-dev libnetcdff-dev     # need BOTH installed

# when using CMake, need to capitalize module name like in CMake
netcdf = dependency('NetCDF', required : false,
  method : 'cmake',
  cmake_module_path : meson.source_root() / 'cmake/Modules')

if fc.links('use netcdf; end', dependencies : netcdf)
  netcdf_rw = executable('netcdf_rw', 'simple_xy_wr.f90', dependencies : netcdf)
  test('NetCDF', netcdf_rw)
else
  message('NetCDF failed to link')
endif
