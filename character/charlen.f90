program charlen
! shows how to properly specify character length and character array

character*(5) :: cb5  ! obsolete, don't use
character(5)  :: c5   ! good to use
character(*),parameter  :: ca(2)='hello'

if (.not.all([len(cb5)==5,len(c5)==5,len(ca)==5,size(ca)==2])) stop 1
print *, ca


end program
