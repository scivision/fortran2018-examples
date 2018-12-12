program typec
!! What happens when variables of one type are assigned to another type

implicit none

logical :: x,y,z

x = 12343
y = 0
z = -1

print *, '12343: true',x
print *, '0: false',y
print *, '-1: true', z

end program
