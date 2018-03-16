! This example is for a typical case of read/write to an n-d array of floating point numbers
! it overwrites existing "filename", since it is the simplest example
! https://support.hdfgroup.org/HDF5/doc/HL/RM_H5LT.html
program hdf5simple

use, intrinsic:: iso_c_binding, only: dp=>c_double
use h5lt, only : hid_t, hsize_t, &
   h5f_acc_trunc_f, &  ! overwrite existing file
   h5open_f, h5fcreate_f, h5ltmake_dataset_double_f, h5fclose_f

implicit none
! -------- user parameters -----------
character(*), parameter :: filename = "hdf5simple.h5" ,& ! file name
                            dsname = "1toN"          ! dataset name
real(dp), allocatable :: array(:)
! -------- HDF5
integer(hid_t) :: fid
integer :: error, length
character(8) :: argv  ! just to keep maximum file size less than about a gigabyte (sanity check)
!-------------------------------------------------

call get_command_argument(1,argv,status=error)
if(error/=0) error stop 'please input array length'
read(argv,'(I8)') length
allocate(array(length))

array = fakedata(length)
call h5write(filename,array)

contains

function fakedata(length)
  integer, intent(in) :: length
  integer :: i
  real(dp) :: fakedata(length)

  do concurrent (i = 1:length)
    fakedata(i) = real(i,dp)
  end do

end function fakedata


subroutine h5write(filename,array)
! convenience function I made, for easy resource.
! it overwrites existing "filename"

  character(*), intent(in) :: filename
  real(dp), intent(in) :: array(:)
  !---------- initialize fortran interface
  call h5open_f(error)
  if (error /= 0) error stop 'could not open hdf5 library'
  !--- create file
  call h5fcreate_f(filename, h5f_acc_trunc_f,fid,error)
  if (error /= 0) error stop 'could not create file'
  !---------- write array to hdf5
  call h5ltmake_dataset_double_f(fid,dsname,rank(array),shape(array,hsize_t),array,error)
  if (error /= 0) error stop 'could not write data'
  !----------- close file
  call h5fclose_f(fid,error)
  if (error /= 0) error stop 'could not close file'

  print *,'created ',filename

end subroutine h5write

end program

