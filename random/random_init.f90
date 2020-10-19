submodule (random) randinit

implicit none (type, external)

contains

module procedure rand_init
integer :: n, u,ios, i
integer, allocatable :: seed(:),check(:)

call random_seed(size=n)
allocate(seed(n),check(n))

open(newunit=u, file='/dev/urandom', access="stream", &
     form="unformatted", action="read", status="old", iostat=ios)

if (ios/=0) return

read(u,iostat=ios) seed
close(u)

call random_seed(put=seed)
!print *,'seed: ',seed    ! for debug/test

end procedure rand_init

end submodule randinit
