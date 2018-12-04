program terminal_io
use, intrinsic:: iso_fortran_env
implicit none

character(80) :: txt

write(output_unit,'(A,I1)') 'This is stdout, unit # ',output_unit
write(error_unit,'(A,I1,A,I1)') 'This is stderr, unit # ',error_unit,' type anything you want to input_unit # ',input_unit
read(input_unit,*) txt

print *,'you typed ',txt

end program
