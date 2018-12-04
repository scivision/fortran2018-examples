module h5mod
! https://support.hdfgroup.org/HDF5/doc/HL/RM_H5LT.html
use, intrinsic:: iso_fortran_env, only: dp=>real64
use h5lt, only : hid_t, hsize_t, &
   h5f_acc_trunc_f, &  ! overwrite existing file
   h5open_f, h5fcreate_f, h5ltmake_dataset_double_f, h5fclose_f

implicit none
private 

public:: h5write

contains


subroutine h5write(filename,dsname,array)
! convenience function I made, for easy resource.
! it overwrites existing "filename"

  character(*), intent(in) :: filename,dsname
  real(dp), intent(in) :: array(:)
  
  integer(hid_t) :: fid
  integer :: ioerr
  !---------- initialize fortran interface
  call h5open_f(ioerr)
  if (ioerr /= 0) error stop 'could not open hdf5 library'
  !--- create file
  call h5fcreate_f(filename, h5f_acc_trunc_f,fid,ioerr)
  if (ioerr /= 0) error stop 'could not create file'
  !---------- write array to hdf5
  print *,shape(array)
  call h5ltmake_dataset_double_f(fid,dsname,rank(array),shape(array,hsize_t),array,ioerr)
  if (ioerr /= 0) error stop 'could not write data'
  !----------- close file
  call h5fclose_f(fid,ioerr)
  if (ioerr /= 0) error stop 'could not close file'

  print *,'created ',filename

end subroutine h5write

end module
