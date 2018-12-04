! this example is for a typical case of read/write to an n-d array of floating point numbers
program h5rw

use,intrinsic:: iso_fortran_env, only: dp=>real64
use hdf5

implicit none
! -------- user parameters -----------
character(len=*), parameter :: filename = "simple.h5", dsname = "my_image"

! -------- initialize hdf5 -----------
integer(hid_t) :: fid        ! file identifier
integer(hid_t) :: dset_id    ! dataset identifier
integer(hid_t) :: dspace_id  ! dataspace identifier
integer(hid_t) :: mspace_id  ! memory id
integer(hsize_t) :: data_dims(rank)  ! size of array
! -------- general variables ------------------  
integer, parameter :: sp = selected_real_kind(6,37)   ! single-precision float
integer, parameter :: dp = selected_real_kind(15,307) ! double-precision float

integer :: ioerr ! error flag
integer :: i

! data buffers (pointers hook to these target arrays):
real(kind=dp), target :: din(9), dout(9)

type(c_ptr) :: f_ptr
!----------------------
! data to write (arbitrary)
real(dp) :: array(9)
array = [1., 2., 3., 4., 5., 6., 7., 8., 9.]

data_dims = size(array)

din = array

  ! initialize fortran interface.

call h5open_f(ioerr)
if (ioerr /= 0) error stop 'could not open hdf5 library'

call h5fcreate_f(filename, h5f_acc_trunc_f, fid, ioerr)
if (ioerr /= 0) error stop 'could not create hdf5 file'

! create dataspaces for datasets
call h5screate_simple_f(rank, data_dims, dspace_id, ioerr)
if (ioerr /= 0) error stop 'could not create data space'
! create the dataset.
call h5dcreate_f(fid, dsname, h5kind_to_type(dp,h5_real_kind), dspace_id, dset_id, ioerr)
if (ioerr /= 0) error stop 'could not create dataset'
! write the dataset.
f_ptr = c_loc(din(1))
call h5dwrite_f(dset_id, h5kind_to_type(dp,h5_real_kind), f_ptr, ioerr)
if (ioerr /= 0) error stop 'could not write dataset'
! close the file
call h5fclose_f(fid, ioerr)
if (ioerr /= 0) error stop 'could not close file after write'

! open the file to read
call h5fopen_f(filename, h5f_acc_rdwr_f, fid, ioerr)
if (ioerr /= 0) error stop 'could not open hdf5 file'
! read the dataset.
! read data back into an integer size that is larger then the original size used for writing the data
f_ptr = c_loc(dout(1))
call h5dread_f(dset_id, h5kind_to_type(dp,h5_real_kind), f_ptr,  ioerr)
if (ioerr /= 0) error stop 'could not read hdf5 dataset'
print *,dout
! close the dataset.
call h5dclose_f(dset_id, ioerr)
if (ioerr /= 0) error stop 'could not read hdf5 dataset after read'
! close the file.
call h5fclose_f(fid, ioerr)
if (ioerr /= 0) error stop 'could not close hdf5 dataset after read'
! close fortran interface.
call h5close_f(ioerr)
if (ioerr /= 0) error stop 'could not close hdf5 file after read'

end program

