program intel_svd
use lapack95,only: gesvd
implicit none

include 'kind.txt'

real(wp):: A(3,3) = reshape( &
        [ 1, 0, 1, &
         -1,-2, 0, &
          0, 1,-1 ], &
           shape(A))

real(wp) :: s(size(a,1)), er(size(s)), maxerr


call gesvd(A,S)

er = S - [2.460504870018764_wp, 1.699628148275318_wp, 0.239123278256554_wp]

print *,'error:',er

maxerr=maxval(abs(er))

if (maxerr > 1e-7_wp) error stop 'excessive singular value error'


end program
