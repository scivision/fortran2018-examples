!! What happens when variables of one type are assigned to another type

implicit none

logical :: x,y,z

x = 12343
y = 0
z = -1

if(.not.x) error stop '12345 should be True'
print *, '12343: true',x

if(y) error stop '0 should be False'
print *, '0: false',y

if(.not.z) error stop '-1 should be True'
print *, '-1: true', z

end program
