program str2int
!! very simple demo of string to integer
implicit none

character(:), allocatable :: x
integer :: m

x = '42'
m = str2int(x)
if (x/=42) error stop

contains

pure integer function str2int(str) result (int)
character(*), intent(in) :: str
read(str,*) int
end function str2int

end program
