program bitpat
! shows how bit masks "Z" and octets "O" work in Fortran
use, intrinsic:: iso_fortran_env, only: int64
implicit none

integer, parameter :: I(*)=[O"4000000000",O"20000000",O"100000",O"400",O"2"]
integer, parameter :: J(*)=[  2**29      ,  2**22    , 2**15   , 2**8 , 2**1 ]

integer(int64),parameter :: K = O"201004020100"
!2**34+2**27+2**20+2**13+2**6

print *,k,i

if (all(i==j)) print *,'OK'

end program
