! This example is for a typical case of read/write to an n-d array of floating point numbers
! it overwrites existing "filename", since it is the simplest example
! https://support.hdfgroup.org/HDF5/doc/HL/RM_H5LT.html
program hdf5simple
use, intrinsic:: iso_fortran_env, only: dp=>real64
use h5mod, only: h5write

implicit none
! -------- user parameters -----------
character(*), parameter :: filename = "simple.h5" ,& ! file name
                            dsname = "1toN"          ! dataset name
real(dp), allocatable :: array(:)
integer :: length,ioerr
character(8) :: argv  ! just to keep maximum file size less than about a gigabyte (sanity check)
!-------------------------------------------------

call get_command_argument(1,argv,status=ioerr)
if(ioerr/=0) error stop 'please input array length'
read(argv,'(I8)') length
allocate(array(length))
array = fakedata(length)

call h5write(filename,dsname,array)

contains

function fakedata(length)
  integer, intent(in) :: length
  integer :: i
  real(dp) :: fakedata(length)

  do concurrent (i = 1:length)
    fakedata(i) = real(i,dp)
  end do

end function fakedata


end program

