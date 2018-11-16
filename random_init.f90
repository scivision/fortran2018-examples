program testinit

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

call init_random_seed()


contains


subroutine init_random_seed()
  ! NOTE: this subroutine is replaced by "call random_init()" intrinsic of Fortran 2018
  integer :: n, u,ios
  integer, allocatable :: seed(:),check(:)

  call random_seed(size=n)
  allocate(seed(n),check(n))
  
  open(newunit=u, file='/dev/urandom', access="stream", &
               form="unformatted", action="read", status="old", iostat=ios)
  
  if (ios==0) then
    read(u,iostat=ios) seed
    
    if (ios/=0) then
      write(stderr,*) 'failed to read random source generator'
      stop 1
    endif
    
    close(u)
    
    call random_seed(put=seed)
  else
    call random_seed()   ! gfortran and ifort compilers pick a fresh seed.
    call random_seed(get=check)
    call random_seed()
    call random_seed(get=seed)
    if (all(check==seed)) write(stderr,*) 'WARNING: your compiler is not picking a unique seed'
  endif
    
  print *,'seed: ',seed    ! for debug/test

end subroutine

end program
