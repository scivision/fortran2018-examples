! This example is for a typical case of read/write to an N-D array of floating point numbers
PROGRAM science_data

USE ISO_C_BINDING
USE HDF5

IMPLICIT NONE
! -------- user parameters -----------
CHARACTER(LEN=*), PARAMETER :: filename = "floatscience.h5" ! File name
CHARACTER(LEN=*), PARAMETER :: dsname = "my_image"          ! Dataset name
INTEGER,parameter :: rank=1  ! rank of user array

! -------- initialize HDF5 -----------
INTEGER(HID_T) :: fid        ! File identifier
INTEGER(HID_T) :: dset_id    ! Dataset identifier
INTEGER(HID_T) :: dspace_id  ! Dataspace identifier
integer(HID_T) :: mspace_id  ! memory ID
INTEGER(HSIZE_T) :: data_dims(rank)  ! size of array
! -------- general variables ------------------  
INTEGER, PARAMETER :: sp = SELECTED_REAL_KIND(6,37)   ! single-precision float
INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(15,307) ! double-precision float

INTEGER :: error ! Error flag
INTEGER :: i

! Data buffers (pointers hook to these target arrays):
REAL(kind=dp), TARGET :: din(9), dout(9)

TYPE(C_PTR) :: f_ptr
!----------------------
! data to write (arbitrary)
REAL(dp) :: array(9)
array = [1., 2., 3., 4., 5., 6., 7., 8., 9.]

data_dims = size(array)

din = array

  ! Initialize FORTRAN interface.

CALL h5open_f(error)
if (error /= 0) error stop 'could not open HDF5 library'

CALL h5fcreate_f(filename, H5F_ACC_TRUNC_F, fid, error)
if (error /= 0) error stop 'could not create HDF5 file'

! Create dataspaces for datasets
CALL h5screate_simple_f(rank, data_dims, dspace_id, error)
if (error /= 0) error stop 'could not create data space'
! Create the dataset.
CALL H5Dcreate_f(fid, dsname, h5kind_to_type(dp,H5_REAL_KIND), dspace_id, dset_id, error)
if (error /= 0) error stop 'could not create dataset'
! Write the dataset.
f_ptr = C_LOC(din(1))
CALL h5dwrite_f(dset_id, h5kind_to_type(dp,H5_REAL_KIND), f_ptr, error)
if (error /= 0) error stop 'could not write dataset'
! Close the file
CALL h5fclose_f(fid, error)
if (error /= 0) error stop 'could not close file after write'

! Open the file to read
CALL h5fopen_f(filename, H5F_ACC_RDWR_F, fid, error)
if (error /= 0) error stop 'could not open HDF5 file'
! Read the dataset.
! Read data back into an integer size that is larger then the original size used for writing the data
f_ptr = C_LOC(dout(1))
CALL h5dread_f(dset_id, h5kind_to_type(dp,H5_REAL_KIND), f_ptr,  error)
if (error /= 0) error stop 'could not read HDF5 dataset'
print *,dout
! Close the dataset.
CALL h5dclose_f(dset_id, error)
if (error /= 0) error stop 'could not read HDF5 dataset after read'
! Close the file.
CALL h5fclose_f(fid, error)
if (error /= 0) error stop 'could not close HDF5 dataset after read'
! Close FORTRAN interface.
CALL h5close_f(error)
if (error /= 0) error stop 'could not close HDF5 file after read'

END PROGRAM science_data

