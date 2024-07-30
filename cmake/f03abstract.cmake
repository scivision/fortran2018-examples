set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine r()
type, abstract :: L1
integer, pointer :: bullseye(:,:)
end type L1

type, extends(L1) :: L2
integer, pointer :: arrow(:)
end type L2

class(L2), allocatable :: obj

end subroutine"
f03abstract
)
