program intel_svd
use lapack95,only: gesvd

use,intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, compiler_version, stderr=>error_unit

implicit none

! Intel(R) Fortran Intel(R) 64 Compiler for applications running on Intel(R) 64, 
! Version 19.0.1.144 Build 20181018
! 64 bits: error mag:  -8.881784197001E-16 -2.220446049250E-16  5.551115123126E-16
! 32 bits: error mag:   2.384185791016E-07  0.000000000000E+00  5.960464477539E-08

!  GCC version 7.3.0
! 64 bits: error mag:  -8.881784197001E-16 -2.220446049250E-16  5.551115123126E-16
! 32 bits: error mag:   2.384185791016E-07  0.000000000000E+00  5.960464477539E-08

! Flang, PGI  had MKL source compiling or linking difficulties

real(dp):: A(3,3) = reshape( &
        [ 1, 0, 1, &
         -1,-2, 0, &
          0, 1,-1 ], &
           shape(A))

integer, parameter :: M = size(a,1), N = size(a,2)

real(dp) :: s64(M), e64(M), maxerr
real(sp) :: s32(M), a32(M, N), e32(M)

A32 = A


call gesvd(A,s64)
e64 = s64 - [2.460504870018764_dp, 1.699628148275318_dp, 0.239123278256554_dp]

print *,compiler_version()
print '(I3,A,3ES20.12)',storage_size(s64),' bits: error mag: ',e64

call gesvd(A32, s32)
e32 = s32 - [2.460504870018764_sp, 1.699628148275318_sp, 0.239123278256554_sp]

print '(I3,A,3ES20.12)',storage_size(s32),' bits: error mag: ',e32

maxerr=maxval(abs(e64))

if (maxerr > 1e-7_dp) then
  write(stderr,*) 'excessive singular value error'
  stop 1
endif

end program
