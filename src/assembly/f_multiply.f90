program multiply_power

implicit none

character(2) :: argv
real :: x, y

call get_command_argument(1, argv)

read(argv,'(i2)') y

x = y*y

end program
