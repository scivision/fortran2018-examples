program intel_svd

use lapack95,only: gesvd
use, intrinsic:: iso_fortran_env, only: dp=>real64
implicit none

real(dp):: A(3,3) = reshape( &
        [ 1, 0, 1, &
         -1,-2, 0, &
          0, 1,-1 ], &
           shape(A))

real(dp) :: s(size(a,1)), er(size(s)), maxerr


call gesvd(A,S)

er = S - [2.460504870018764, 1.699628148275318, 0.239123278256554]

print *,'error:',er

maxerr=maxval(abs(er))

if (maxerr > 1e-7) error stop 'excessive singular value error'





end program
