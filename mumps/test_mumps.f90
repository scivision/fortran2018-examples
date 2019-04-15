!! Based on MUMPS manual Sec 11.1
use mpi, only: mpi_init, mpi_finalize, mpi_comm_world
use, intrinsic :: iso_fortran_env, only: stderr=>error_unit, stdout=>output_unit, i64=>int64

IMPLICIT NONE

INCLUDE 'dmumps_struc.h'
TYPE (DMUMPS_STRUC) :: mumps_par

integer :: ierr

CALL MPI_INIT(ierr)
if (ierr /= 0) error stop 'mpi init error'
!> Define a communicator for the package.
mumps_par%COMM = MPI_COMM_WORLD  !mpi_val

!>  Initialize an instance of the package for L U factorization (sym = 0, with working host)
mumps_par%SYM = 0
!! A is unsymmetric   Sec. 5.2.1 page 24

mumps_par%PAR = 1
!! use host to compute too  Sec 5.1.3 page 23

mumps_par%JOB = -1
!! Initializes all variables, set job parameters first.  Sec 5.1, page 22

!> set verbosities AFTER %JOB call or they get reset!
mumps_par%ICNTL(1) = stderr
!! error msg stream

mumps_par%ICNTL(2) = stdout
!! warning msg stream

mumps_par%ICNTL(4) = 1
!! only error messags

call simple_test(mumps_par)

CALL MPI_FINALIZE(ierr)

contains


subroutine simple_test(mumps_par)

TYPE (DMUMPS_STRUC), intent(inout) :: mumps_par

call mumps_run(mumps_par)
!! update MUMPS with user parameters


call read_input(mumps_par)
!! Define problem on the host (processor 0)

!>  Call package for solution
mumps_par%JOB = 6
call mumps_run(mumps_par)

!>  Solution has been assembled on the host
IF ( mumps_par%MYID == 0 ) THEN
  print *, ' Solution is '
  print '(5F7.3)', mumps_par%RHS

!>  Deallocate user data
  DEALLOCATE( mumps_par%IRN )
  DEALLOCATE( mumps_par%JCN )
  DEALLOCATE( mumps_par%A   )
  DEALLOCATE( mumps_par%RHS )
END IF

!>  Destroy the instance (deallocate internal data structures)
mumps_par%JOB = -2
call mumps_run(mumps_par)

end subroutine simple_test


subroutine read_input(mumps_par)

type(dmumps_struc), intent(inout) :: mumps_par
integer :: I, u
INTEGER(i64) :: I8

IF ( mumps_par%MYID == 0 ) THEN

open(newunit=u, file='input_simpletest_real', form='formatted', status='old', action='read')
READ(u,*) mumps_par%N
READ(u,*) mumps_par%NNZ
ALLOCATE( mumps_par%IRN ( mumps_par%NNZ ) )
ALLOCATE( mumps_par%JCN ( mumps_par%NNZ ) )
ALLOCATE( mumps_par%A( mumps_par%NNZ ) )
ALLOCATE( mumps_par%RHS ( mumps_par%N  ) )
DO I8 = 1, mumps_par%NNZ
  READ(u,*) mumps_par%IRN(I8),mumps_par%JCN(I8), mumps_par%A(I8)
END DO
DO I = 1, mumps_par%N
  READ(u,*) mumps_par%RHS(I)
END DO
close(u)

END IF

end subroutine read_input


subroutine mumps_run(mumps_par)

type(dmumps_struc), intent(inout) :: mumps_par

CALL DMUMPS(mumps_par)

IF(mumps_par%INFOG(1) < 0) THEN
  WRITE(stderr,*) "ERROR: "
  write(stderr,'(A,I6,A,I9)')"  mumps_par%INFOG(1)= ", mumps_par%INFOG(1),  "  mumps_par%INFOG(2)= ", mumps_par%INFOG(2)
  error stop
elseiF(mumps_par%INFOG(1) > 0) THEN
  WRITE(stderr,*) "WARNINGG: "
  write(stderr,'(A,I6,A,I9)')"  mumps_par%INFOG(1)= ", mumps_par%INFOG(1),  "  mumps_par%INFOG(2)= ", mumps_par%INFOG(2)
END IF

end subroutine mumps_run

end program
