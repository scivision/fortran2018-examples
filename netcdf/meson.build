
netcdf_rw = executable('netcdf_rw', 'simple_xy_wr.f90', dependencies : netcdf)
test('NetCDF', netcdf_rw,
  timeout: 20)
