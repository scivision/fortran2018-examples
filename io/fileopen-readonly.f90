!! NOTE: chmod is non-standard, and will crash ifort runtime.

use, intrinsic :: iso_fortran_env, only: stderr=>error_unit
implicit none

character(*),parameter :: fnro='ro.txt'

  call createro(fnro)
  call deletefile(fnro) ! this is MY unlink, since the GNU extension is non-standard and crashes ifort runtimes.
  print *,'deleted read-only: ',fnro

contains


subroutine createro(fn)
  ! creates  file to delete
  character(*),intent(in) :: fn
  character(*),parameter :: txt='i am read only'
  integer :: u

  open(newunit=u, file=fn, form='formatted', status='unknown', action='write')

  write(u, *) txt

  close(u)

  print *,'created read-only: ',fn

end subroutine


subroutine deletefile(fn)
  character(*), intent(in) :: fn
  integer :: u, ios
  logical :: fexist

!! Fortran-standard way to delete a file.
  open(newunit=u, file=fn, status='old')
  close(u, status='delete', iostat=ios)

  if (ios/=0) then
    write(stderr,*) 'failed to delete',fn,ios
    error stop
  endif

  inquire(file=fn, exist=fexist)

  if (fexist) then
    write(stderr,*) 'failed to delete',fn
    error stop
  endif

end subroutine deletefile

end program
