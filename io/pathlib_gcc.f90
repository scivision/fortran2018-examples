submodule (pathlib) isdir

implicit none (type, external)

contains

module procedure is_directory
!! For GCC Gfortran, similar for other compilers
integer :: i, statb(13)
character(:), allocatable :: wk

wk = expanduser(path)

!! must not have trailing slash on Windows
i = len_trim(wk)
if (wk(i:i) == char(92) .or. wk(i:i) == '/') wk = wk(1:i-1)


inquire(file=wk, exist=is_directory)
if(.not.is_directory) return

i = stat(wk, statb)
if(i /= 0) then
  is_directory = .false.
  return
endif

i = iand(statb(3), O'0040000')
is_directory = i == 16384

! print '(O8)', statb(3)
end procedure is_directory

end submodule isdir
