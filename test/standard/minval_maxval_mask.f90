program minval_maxval_mask

implicit none

integer :: A(5) = [0, 5, 1, 2, 3]
integer :: L

logical :: mask(size(A))


if(maxval(A, dim=1) /= 5) error stop "maxval sanity"
if(minval(A, dim=1) /= 0) error stop "minval sanity"

if(maxval(A, dim=1, mask=[.true., .false., .true., .true., .true.]) /= 3) error stop "maxval mask sanity"
if(minval(A, dim=1, mask=[.false., .true., .true., .true., .true.]) /= 1) error stop "minval mask sanity"

mask = .false.
if (maxval(A, dim=1, mask=mask) /= -huge(0)-1) error stop "maxval mask = .false."
if (minval(A, dim=1, mask=mask) /= huge(0)) error stop "minval mask = .false."

print *, "OK: minval_maxval_mask"

end program



! if (maxval(A, dim=1, mask=mask) /= huge(0)) error stop "maxval mask = .false."
