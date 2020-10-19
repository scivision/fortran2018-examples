program test_pathlib
use pathlib, only: copyfile, mkdir, expanduser, home
implicit none (type, external)

call test_home()
call test_expanduser('~')
call test_mkdir('testdir/hello')
call test_mkdir('testdir/hello/')

contains

subroutine test_home()
character(:), allocatable :: h

h = home()
if (len(h) < 2) error stop 'failed to obtain home directory: ' // h

end subroutine test_home

subroutine test_expanduser(path)
!! NOTE: when testing, enclose argument in '~/test.txt' quotes or
!!  shell will expand '~' before it gets to Fortran!

character(:), allocatable :: expanded
character(*), intent(in) :: path

expanded = expanduser(path)

if (len_trim(expanded) <= len_trim(path)) error stop 'did not expand path' // path // ' ' // expanded

print *,'OK: expanduser'

end subroutine test_expanduser


subroutine test_mkdir(path)
character(*), intent(in) :: path
character(:), allocatable :: fpath
integer :: ret, u
logical :: exists

ret = mkdir(path)
fpath = path // '/foo.txt'

! check existance of path by writing file and checking file's existance
open(newunit=u, file=fpath, action='write', status='replace', iostat=ret)
if (ret/=0) error stop 'could not create file in test directory'
write(u,'(A)') 'bar'
close(u)

inquire(file=fpath, exist=exists)
if(.not.exists) error stop fpath // ' failed to be created'

print *, 'OK: mkdir()'
end subroutine test_mkdir

end program
