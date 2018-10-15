program bitpat
! shows how bit masks "Z" and octets "O" work in Fortran
! https://gcc.gnu.org/onlinedocs/gfortran/BOZ-literal-constants.html
use, intrinsic:: iso_fortran_env
implicit none

! note that if you want other than default elements of array, you must use e.g. int( , int64) on each element
! or use a DATA statement, as per
! https://groups.google.com/forum/#!topic/comp.lang.fortran/AFtpnBh6eLg
integer, parameter :: I(*) = [O"4000000000",O"20000000",O"100000",O"400",O"2"]  ! GNU extension, non-standard
integer, parameter :: J(*) = [  2**29      ,  2**22    , 2**15   , 2**8 , 2**1 ]


integer(int64), parameter :: hexa(*) = [z'80000000']

integer(int64),parameter :: K = int(O"201004020100",int64)
!2**34+2**27+2**20+2**13+2**6

! while it's allowed to put BOZ at end, standard is to put BOZ at front
integer,parameter :: K1 = int(O'50147')


print '(A,5I12)','exp',j

print '(A,5I12)','BOZ',i

if (.not.all(i==j)) error stop 'bit pattern mismatch'
if (.not.i(1)==536870912) error stop 'bit pattern mismatch'
if (.not.j(1)==536870912) error stop 'bit pattern mismatch'
if (.not.k1==20583) error stop 'bit pattern mismatch'
if (.not.k==17315143744_int64) error stop 'bit pattern mismatch'

print *,'--------------'
print *,hexa

end program
