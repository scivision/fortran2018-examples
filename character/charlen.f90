program charlen
!! shows how to properly specify character length and character array

implicit none (type, external)

character*(5) :: cb5  !< obsolete, don't use

!>  good to use
character(5)  :: c5
character(*), parameter :: ca(2) = ['hello', 'sorry']

if (.not.all([len(cb5)==5, len(c5)==5, len(ca)==5, size(ca)==2])) error stop
print *, ca

end program
