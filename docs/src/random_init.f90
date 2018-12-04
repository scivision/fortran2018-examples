submodule (random) randinit

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

contains

module procedure random_init
! NOTE: this subroutine is replaced by "call random_init()" intrinsic of Fortran 2018
integer :: n, u,ios, i
integer, allocatable :: seed(:),check(:)

call random_seed(size=n)
allocate(seed(n),check(n))

open(newunit=u, file='/dev/urandom', access="stream", &
     form="unformatted", action="read", status="old", iostat=ios)

if (ios==0) then
  read(u,iostat=ios) seed
  close(u)
endif
  
if (ios/=0) then
  write(stderr,*) 'falling back to internal random number generator'
  do i = 1,n
    seed(i) = randint(-1073741823, 1073741823) 
  enddo
endif

call random_seed(put=seed)
!print *,'seed: ',seed    ! for debug/test

end procedure random_init

end submodule randinit
