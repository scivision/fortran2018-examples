check_source_compiles(Fortran
"program abst

implicit none

type, abstract :: L1
integer, pointer :: bullseye(:,:)
end type L1

type, extends(L1) :: L2
integer, pointer :: arrow(:)
end type L2

class(L2), allocatable :: obj

end program
"
f03abstract
)
