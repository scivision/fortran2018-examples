program std_mkdir
!! Fortran standard compliant mkdir().
!! mkdir() is a GNU extension, not standard Fortran.
use, intrinsic:: iso_c_binding, only: c_int, c_char
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
implicit none

!> use this interface in your module
interface
integer(c_int) function mkdir_c(path, mask) bind (C, name='mkdir')
  import c_int, c_char
  character(kind=c_char), intent(in) :: path(*)
  integer(c_int), value, intent(in) :: mask
end function mkdir_c
end interface

!> demo
character(4096) :: buf
integer(c_int) :: ret

call get_command_argument(1,buf)

ret = mkdir(trim(buf))

print *, ret

contains

function mkdir(path) result(ret)
!! create a directory, with parents if needed
!! N.B. inquire() does not work for directories by Fortran standard

integer(c_int) :: ret
integer :: i,i0, i1
character(len=*), intent(in) :: path
character(kind=c_char, len=:), allocatable :: buf
!! must use allocatable buffer, not direct substring to C

if (len(path) == 0) then
  write(stderr,*) 'must specify directory to create'
  stop 1
endif

!> single directory
i = index(path, '/')
if (i==0) then
  ret = mkdir_c(path, int(o'755', c_int))
  return
endif

!> parents
i=-1
i0=1
do while( i /= 0 )
  i1 = i0

  i = index(path(i0:), '/')
  
  if(i /= 0) then
    i0 = i0+i
  elseif(i0 == i1) then
    return
  else
    i0 = len(path)+1
  endif
 
  !> allocated string buffer necessary for C interface
  buf = path(1:i0-1)

  ret = mkdir_c(buf, int(o'755', c_int))
  !print *,i,i0,ret,buf
  deallocate(buf)
enddo

end function mkdir
end program
