program testinit

implicit none

call init_random_seed()


contains


subroutine init_random_seed()
  ! NOTE: this subroutine is replaced by "call random_init()" intrinsic of Fortran 2018
  integer :: n, u,ios
  integer, allocatable :: seed(:)

  call random_seed(size=n)
  allocate(seed(n))
  
  open(newunit=u, file='/dev/urandom', access="stream", &
               form="unformatted", action="read", status="old", iostat=ios)
  if (ios/=0) error stop 'failed to open random source generator'
  
  read(u,iostat=ios) seed
  if (ios/=0) error stop 'failed to read random source generator'
  
  close(u)
  
  call random_seed(put=seed)
  
  
  print *,'seed: ',seed    ! for debug/test

end subroutine

end program
