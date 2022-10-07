program timeprec
!! demonstrates  timing methods
use, intrinsic:: iso_fortran_env, only: dp=>real64, int64

implicit none

integer(int64) :: tic,toc,rate

call system_clock(tic,count_rate=rate)
call timempi()
call system_clock(toc)

print '(A,ES12.5,A)','intrinsic time: ',(toc-tic)/real(rate,dp),' seconds.'

contains

subroutine timempi()

use omp_lib, only : omp_get_wtime, omp_get_num_procs, omp_get_num_threads, omp_get_thread_num

integer(int64), external :: omp_get_wtick

integer :: Ncore, Nthread
real(dp) :: tic,toc,rate

rate = omp_get_wtick()
print '(A,ES10.3,A)','OpenMP tick time: ',rate,' second.'

!$omp parallel private(tic,toc)

tic = omp_get_wtime()
! left these statements here to give a little entropy to per-thread timing.
Ncore = omp_get_num_procs()
Nthread = omp_get_num_threads()


!$omp master
  print *,Nthread,'CPU threads used.',Ncore,' processor cores detected.'
!$omp end master

toc = omp_get_wtime()

print *,'Thread: ',omp_get_thread_num(),(toc-tic)/rate

!$omp end parallel
end subroutine timempi

end program
