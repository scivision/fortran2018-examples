use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
use pathlib, only: copyfile, mkdir
implicit none

call test_mkdir()

contains

subroutine test_mkdir()

character(4096) :: buf
character(:), allocatable :: path, fpath
integer :: ret, u
logical :: exists

call get_command_argument(1,buf)
path = trim(buf)
fpath = path // '/foo.txt'

ret = mkdir(path)

! check existance of path by writing file and checking file's existance
open(newunit=u, file=fpath, action='write', status='replace')
write(u,'(A)') 'bar'
close(u)

inquire(file=fpath, exist=exists)
if(.not.exists) then
  write(stderr,*) fpath // ' failed to be created'
  error stop
endif

print *, 'OK: mkdir()'
end subroutine test_mkdir

end program