program charlen
! shows how to properly specify character length and character array

character*(5) :: cb5
character(5)  :: c5
character*(*),parameter  :: ca(2)='hello'

print *,len(cb5),len(c5),len(ca),size(ca)
print *, ca


end program
