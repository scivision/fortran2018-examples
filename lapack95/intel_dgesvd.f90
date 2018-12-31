program intel_svd

use,intrinsic:: iso_fortran_env, only: sp=>real32, dp=>real64, compiler_version, stderr=>error_unit

implicit none

! Intel(R) Fortran Intel(R) 64 Compiler for applications running on Intel(R) 64, 
! Version 19.0.1.144 Build 20181018
! 64 bits: error mag:   0.000000000000E+00  0.000000000000E+00  0.000000000000E+00


! GCC version 7.3.0  (system Lapack)
! 64 bits: error mag:   0.000000000000E+00  2.220446049250E-16  4.996003610813E-16

! GCC version 7.3.0  (MKL 19)
! 64 bits: error mag:   6.952923663893-310  6.941716482845-310  4.940656458412-324

! pgf90 18.10-0 (system Lapack
! 64 bits: error mag:   0.000000000000E+00  2.220446049250E-16  4.996003610813E-16

! pgf90 18.10-0 (MKL 19)
! 64 bits: error mag:   0.000000000000E+00  0.000000000000E+00  0.000000000000E+00

! Flang does not work with system Lapack, may need to compile lapack
real(dp):: A(3,3) = reshape( &
        [ 1, 0, 1, &
         -1,-2, 0, &
          0, 1,-1 ], &
           shape(A))

integer :: svdinfo
integer, parameter :: M = size(a,1), N = size(a,2), Lratio = 5
integer, parameter :: LWORK = LRATIO*M
real(dp) :: U(M,M),VT(M,M), SWORK(LRATIO*M)

real(dp) :: ss64(M, N), s64(M), e64(M), maxerr
real(dp), parameter :: s64ref(3) = [2.460504870018764_dp, 1.699628148275318_dp, 0.239123278256554_dp]


call dgesvd('A','N',M,M,A,M,SS64,U,M,VT,M, SWORK, LWORK,svdinfo)
if (svdinfo /=0) then
  write(stderr,*) 'svd error: ',svdinfo
  stop 1
endif

s64 = ss64(:,1)  ! NOT DIAG!!!!

!e64 = s64 - S64ref

print *,compiler_version()
print '(I3,A,3ES20.12)',storage_size(s64),' bits: error mag: ',e64



maxerr=maxval(abs(e64))

if (maxerr > 1e-7_dp) then
  write(stderr,*) 'excessive singular value error'
  stop 1
endif

end program
