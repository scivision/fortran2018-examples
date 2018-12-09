      PROGRAM HELLO
!!     -- BLACS example code --
!!     Written by Clint Whaley 7/26/94
!!     Performs a simple check-in type hello world
      use mpi_f08, only: mpi_init
      INTEGER, external :: BLACS_PNUM

      INTEGER CONTXT, IAM, NPROCS, NPROW, NPCOL, MYPROW, MYPCOL
      INTEGER ICALLER, I, J, HISROW, HISCOL
      
      call mpi_init()

!! Determine my process number and the number of processes in machine

      CALL BLACS_PINFO(IAM, NPROCS)

!!    If in PVM, create virtual machine if it doesn't exist

      IF (NPROCS < 1) THEN
        IF (IAM  == 0) THEN
	        print *, 'How many processes in machine?'
	        READ(*,*) NPROCS
        END IF
        CALL BLACS_SETUP(IAM, NPROCS)
      END IF

!!     Set up process grid that is as close to square as possible

      NPROW = INT( SQRT( REAL(NPROCS) ) )
      NPCOL = NPROCS / NPROW

!!     Get default system context, and define grid

      CALL BLACS_GET(0, 0, CONTXT)
      CALL BLACS_GRIDINIT(CONTXT, 'Row', NPROW, NPCOL)
      CALL BLACS_GRIDINFO(CONTXT, NPROW, NPCOL, MYPROW, MYPCOL)

!!     If I'm not in grid, go to end of program

      IF ( (MYPROW >= NPROW) .OR. (MYPCOL >= NPCOL) ) GOTO 30

!!     Get my process ID from my grid coordinates

      ICALLER = BLACS_PNUM(CONTXT, MYPROW, MYPCOL)
      
!!    If I am process {0,0}, receive check-in messages from all nodes

      IF ( (MYPROW.EQ.0) .AND. (MYPCOL.EQ.0) ) THEN

        print *, ' '
        DO I = 0, NPROW-1
	        DO J = 0, NPCOL-1

	       IF ( (I.NE.0) .OR. (J.NE.0) ) THEN
		  CALL IGERV2D(CONTXT, 1, 1, ICALLER, 1, I, J) 
               ENDIF

!!              Make sure ICALLER is where we think in process grid

               CALL BLACS_PCOORD(CONTXT, ICALLER, HISROW, HISCOL)
               IF ( (HISROW.NE.I) .OR. (HISCOL.NE.J) ) THEN
                  error stop 'Grid error!'

               END IF
	       print *,'Process {',I,',',J,'} (node number =',icaller,
     $       ') has checked in.'

          enddo
        enddo
        print *, ' '
        print *, 'All processes checked in.  Run finished.'

!!    All processes but {0,0} send process ID as a check-in

      ELSE
	 CALL IGESD2D(CONTXT, 1, 1, ICALLER, 1, 0, 0)
      END IF

30    CONTINUE
   
      CALL BLACS_EXIT(0)

      END program
