program hdf5_hello
  use hdf5
  use h5lt
  use h5ds
  integer error
  call h5open_f(error)
  call h5close_f(error)
end
