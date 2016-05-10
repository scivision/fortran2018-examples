! split a string into 2 either side of a delimiter token
function split(instr,  delm)
    implicit none
    CHARACTER(len=80),intent(in) :: instr,delm
    INTEGER :: idx

    idx = scan(instr,delm)
    split = instr(1:idx-1)

end function split
