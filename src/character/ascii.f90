program ascii
!! prints a couple special characters

implicit none (type, external)

print *,'next is a form feed',achar(12)
print *,'that was a form feed'

print *,'this is BEL',achar(7)

end program
