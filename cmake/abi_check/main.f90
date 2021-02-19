program adder

implicit none (type, external)

interface
integer function addone(N) bind(C)
integer, intent(in), value :: N
end function addone
end interface


if (addone(2) /= 3) error stop "unexpected addone result"

print *, "OK: 2+1=3"


end program
