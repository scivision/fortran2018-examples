use sleep_std, only : sleep_millisec
implicit none

character(5) :: argv
integer :: t,i

t = 500
call get_command_argument(1, argv, status=i)
if (i==0) read(argv,'(I5)') t

print '(A,I5,A)', 'Sleeping for ',t,' milliseconds.'

call sleep_millisec(t)

end program