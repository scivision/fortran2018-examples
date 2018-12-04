! https://support.hdfgroup.org/ftp/HDF5/examples/fortran/rwdset_fortran2003.f90

! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!   Copyright by The HDF Group.                                               *
!   Copyright by the Board of Trustees of the University of Illinois.         *
!   All rights reserved.                                                      *
!                                                                             *
!   This file is part of HDF5.  The full HDF5 copyright notice, including     *
!   terms governing use, modification, and redistribution, is contained in    *
!   the files COPYING and Copyright.html.  COPYING can be found at the root   *
!   of the source code distribution tree; Copyright.html can be found at the  *
!   root level of an installed copy of the electronic HDF5 document set and   *
!   is linked from the top-level documents page.  It can also be found at     *
!   http://hdfgroup.org/HDF5/doc/Copyright.html.  If you do not have          *
!   access to either file, you may request a copy from help@hdfgroup.org.     *
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!
!
! The following example shows how to write and read to/from an HDF5 dataset.
! It opens the file after it creates it, obtains the dataset
! identifier, writes the data to the dataset in the file,
! then reads the dataset to memory.
! Uses updated Fortran 2003 interface with different KINDs of integers and reals.
!
PROGRAM RWDSET_FORTRAN2003

  USE ISO_C_BINDING

  USE HDF5 ! This module contains all necessary modules

  IMPLICIT NONE

  INTEGER, PARAMETER :: i1 = SELECTED_INT_KIND(2)  !should map to INTEGER*1 on most modern processors
  INTEGER, PARAMETER :: i4 = SELECTED_INT_KIND(4)  !should map to INTEGER*2 on most modern processors
  INTEGER, PARAMETER :: i8 = SELECTED_INT_KIND(9)  !should map to INTEGER*4 on most modern processors
  INTEGER, PARAMETER :: i16 = SELECTED_INT_KIND(18) !should map to INTEGER*8 on most modern processors

  INTEGER, PARAMETER :: sp = SELECTED_REAL_KIND(6,37) !should map to REAL*4 on most modern processors
  INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(15,307) !should map to REAL*8 on most modern processors

  CHARACTER(LEN=*), PARAMETER :: filename = "dsetf.h5" ! File name
  CHARACTER(LEN=*), PARAMETER :: dsetname1 = "dset1"     ! Dataset name
  CHARACTER(LEN=*), PARAMETER :: dsetname2 = "dset2"     ! Dataset name
  CHARACTER(LEN=*), PARAMETER :: dsetname4 = "dset4"     ! Dataset name
  CHARACTER(LEN=*), PARAMETER :: dsetname8 = "dset8"     ! Dataset name
  CHARACTER(LEN=*), PARAMETER :: dsetnamer4 = "dsetr4"     ! Dataset name
  CHARACTER(LEN=*), PARAMETER :: dsetnamer8 = "dsetr8"     ! Dataset name

  INTEGER(HID_T) :: file_id       ! File identifier
  INTEGER(HID_T) :: dset_id1      ! Dataset identifier
  INTEGER(HID_T) :: dset_id4      ! Dataset identifier
  INTEGER(HID_T) :: dset_id8      ! Dataset identifier
  INTEGER(HID_T) :: dset_id16     ! Dataset identifier
  INTEGER(HID_T) :: dset_idr4      ! Dataset identifier
  INTEGER(HID_T) :: dset_idr8      ! Dataset identifier

  INTEGER :: error ! Error flag
  INTEGER :: i

! Data buffers:

  INTEGER(i1), DIMENSION(1:4), TARGET :: dset_data_i1
  INTEGER(i4), DIMENSION(1:4), TARGET :: dset_data_i4, data_out_i4
  INTEGER(i8), DIMENSION(1:4), TARGET :: dset_data_i8, data_out_i8
  INTEGER(i16), DIMENSION(1:4), TARGET :: dset_data_i16, data_out_i16

  INTEGER(i8), DIMENSION(1:4), TARGET :: data_out_i8a

  REAL(kind=sp), DIMENSION(1:4), TARGET :: dset_data_r7, data_out_r7
  REAL(kind=dp), DIMENSION(1:4), TARGET :: dset_data_r15, data_out_r15


  INTEGER(HSIZE_T), DIMENSION(1:1) :: data_dims = (/4/)
  INTEGER(HID_T) :: dspace_id     ! Dataspace identifier

  TYPE(C_PTR) :: f_ptr


  ! Initialize FORTRAN interface.

  CALL h5open_f(error)
  if (error /= 0) error stop 'could not open HDF5 library'
  !
  ! Initialize the dset_data array.
  !
  DO i = 1, 4
     dset_data_i1(i)  = i
     dset_data_i4(i)  = i
     dset_data_i8(i)  = i
     dset_data_i16(i) = i

     dset_data_r7(i) = (i)*100.
     dset_data_r15(i) = (i)*1000.

  END DO

  CALL h5fcreate_f(filename, H5F_ACC_TRUNC_F, file_id, error)
  !
  ! Create dataspaces for datasets
  !
  CALL h5screate_simple_f(1, data_dims , dspace_id, error)
  !
  ! Create the dataset.
  !
  CALL H5Dcreate_f(file_id, dsetname1, h5kind_to_type(i1,H5_INTEGER_KIND),  dspace_id, dset_id1, error)
  CALL H5Dcreate_f(file_id, dsetname2, h5kind_to_type(i4,H5_INTEGER_KIND),  dspace_id, dset_id4, error)
  CALL H5Dcreate_f(file_id, dsetname4, h5kind_to_type(i8,H5_INTEGER_KIND),  dspace_id, dset_id8, error)
  CALL H5Dcreate_f(file_id, dsetname8, h5kind_to_type(i16,H5_INTEGER_KIND), dspace_id, dset_id16, error)

  CALL H5Dcreate_f(file_id, dsetnamer4, h5kind_to_type(sp,H5_REAL_KIND),  dspace_id, dset_idr4, error)
  CALL H5Dcreate_f(file_id, dsetnamer8, h5kind_to_type(dp,H5_REAL_KIND), dspace_id, dset_idr8, error)

  !
  ! Write the dataset.
  !
  f_ptr = C_LOC(dset_data_i1(1))
  CALL h5dwrite_f(dset_id1, h5kind_to_type(i1,H5_INTEGER_KIND), f_ptr, error)
  f_ptr = C_LOC(dset_data_i4(1))
  CALL h5dwrite_f(dset_id4, h5kind_to_type(i4,H5_INTEGER_KIND), f_ptr, error)
  f_ptr = C_LOC(dset_data_i8(1))
  CALL h5dwrite_f(dset_id8, h5kind_to_type(i8,H5_INTEGER_KIND), f_ptr, error)
  f_ptr = C_LOC(dset_data_i16(1))
  CALL h5dwrite_f(dset_id16, h5kind_to_type(i16,H5_INTEGER_KIND), f_ptr, error)
  f_ptr = C_LOC(dset_data_r7(1))
  CALL h5dwrite_f(dset_idr4, h5kind_to_type(sp,H5_REAL_KIND), f_ptr, error)
  f_ptr = C_LOC(dset_data_r15(1))
  CALL h5dwrite_f(dset_idr8, h5kind_to_type(dp,H5_REAL_KIND), f_ptr, error)
  !
  ! Close the file
  !
  CALL h5fclose_f(file_id, error)

  ! Open the file

  CALL h5fopen_f(filename, H5F_ACC_RDWR_F, file_id, error)
  !
  ! Read the dataset.
  !
  ! Read data back into an integer size that is larger then the original size used for
  ! writing the data
  f_ptr = C_LOC(data_out_i8a(1))
  CALL h5dread_f(dset_id1, h5kind_to_type(i8,H5_INTEGER_KIND), f_ptr,  error)
  f_ptr = C_LOC(data_out_i4(1))
  CALL h5dread_f(dset_id4, h5kind_to_type(i4,H5_INTEGER_KIND), f_ptr,  error)
  f_ptr = C_LOC(data_out_i8(1))
  CALL h5dread_f(dset_id8, h5kind_to_type(i8,H5_INTEGER_KIND), f_ptr,  error)
  f_ptr = C_LOC(data_out_i16(1))
  CALL h5dread_f(dset_id16, h5kind_to_type(i16,H5_INTEGER_KIND), f_ptr,  error)
  f_ptr = C_LOC(data_out_r7(1))
  CALL h5dread_f(dset_idr4, h5kind_to_type(sp,H5_REAL_KIND), f_ptr,  error)
  f_ptr = C_LOC(data_out_r15(1))
  CALL h5dread_f(dset_idr8, h5kind_to_type(dp,H5_REAL_KIND), f_ptr,  error)

! memory type
  WRITE(*,'(A,4i8)' )'SELECTED_INT_KIND(2):  ',data_out_i8a
  WRITE(*,'(A,4i8)' )'SELECTED_INT_KIND(4):  ',data_out_i4
  WRITE(*,'(A,4i8)' )'SELECTED_INT_KIND(9):  ',data_out_i8
  WRITE(*,'(A,4i8)' )'SELECTED_INT_KIND(18): ',data_out_i16
  WRITE(*,'(A,4(1x,f9.4))' )'SELECTED_REAL_KIND(6,37):  ',data_out_r7
  WRITE(*,'(A,4(1x,f16.10))' )'SELECTED_REAL_KIND(15,307):  ',data_out_r15
  !
  ! Close the dataset.
  !
  CALL h5dclose_f(dset_id1, error)
  CALL h5dclose_f(dset_id4, error)
  CALL h5dclose_f(dset_id8, error)
  CALL h5dclose_f(dset_id16, error)
  CALL h5dclose_f(dset_idr4, error)
  CALL h5dclose_f(dset_idr8, error)
  !
  ! Close the file.
  !
  CALL h5fclose_f(file_id, error)
  !
  ! Close FORTRAN interface.
  !
  CALL h5close_f(error)

END PROGRAM RWDSET_FORTRAN2003

