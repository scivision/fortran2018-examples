program str2int_demo
!! very simple demo of string to integer
implicit none (external)

character(:), allocatable :: x
integer :: m

x = '42'
m = str2int(x)
if (m/=42) error stop

contains

pure integer function str2int(str) result (int)
character(*), intent(in) :: str
read(str,*) int
end function str2int

end program
