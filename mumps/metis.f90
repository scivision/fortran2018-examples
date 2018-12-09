!! https://github.com/lanl/qmd-progress/
!! NOTE: should we use iso_c_binding?
program Mtest
use, intrinsic:: iso_fortran_env, only: dp=>real64
implicit none  
!> 0  METIS_OPTION_PTYPE
!>    -- 0 METIS_PTYPE_RB
!>    -- 1 METIS_PTYPE_KWAY
!> 1  METIS_OPTION_OBJTYPE,
!>    -- 0 METIS_OBJTYPE_CUT
!>    -- 1 METIS_OBJTYPE_VOL
!> 2  METIS_OPTION_CTYPE,
!> 3  METIS_OPTION_IPTYPE,
!> 4  METIS_OPTION_RTYPE,
!> 5  METIS_OPTION_DBGLVL,
!> 6  METIS_OPTION_NITER,
!> 7  METIS_OPTION_NCUTS,
!> 8  METIS_OPTION_SEED,
!> 9  METIS_OPTION_NO2HOP,
!> 10 METIS_OPTION_MINCONN,
!> 11 METIS_OPTION_CONTIG,
!> 12 METIS_OPTION_COMPRESS,
!> 13 METIS_OPTION_CCORDER,
!> 14 METIS_OPTION_PFACTOR,
!> 15 METIS_OPTION_NSEPS,
!> 16 METIS_OPTION_UFACTOR,
! 17 METIS_OPTION_NUMBERING,
!>    -- 0 C-style numbering is assumed that starts from 0
!>    -- 1 Fortran-style numbering is assumed that starts from 1
!>  Used for command-line parameter purposes 
!> 18 METIS_OPTION_HELP,
!> 19 METIS_OPTION_TPWGTS,
!> 20 METIS_OPTION_NCOMMON,
!> 21 METIS_OPTION_NOOUTPUT,
!> 22 METIS_OPTION_BALANCE,
!> 23 METIS_OPTION_GTYPE,
!> 24 METIS_OPTION_UBVEC
integer, allocatable :: options(:)
integer, parameter  :: nvtxs=15, ncon=1
integer          :: xadj(nvtxs+1), adjncy(44), part(nvtxs), j, nparts, objval, refpart(nvtxs)
integer, pointer   :: vwgt=>null(), vsize=>null(), adjwgt=>null()
real(dp), pointer  :: tpwgts=>null(), ubvec=>null()
allocate(options(0:40))

call METIS_SetDefaultOptions(options)

nparts=4
objval=1
options(0) = 1
options(1) = 0 
options(8) = 1
options(17) = 1

part = 0

xadj=[1, 3, 6, 9, 12, 14, 15, 21, 25, 29, 32, 34, 37, 40, 43, 45]
adjncy=[2, 6, 1, 3, 7, 2, 4, 8, 3, 5, 9, 4, 10, 1, 7, 11, 12, 6, 8,&
12, 3, 7, 9, 13, 4, 8, 10, 14, 5, 9, 15, 6, 12, 7, 11, 13, 8, 12, 14,&
9, 13, 15, 10, 14]
 
call METIS_PartGraphKway(nvtxs, ncon, xadj, adjncy, vwgt, vsize, adjwgt, nparts, tpwgts, ubvec, options, objval, part)


do, j=1,nvtxs
  write(*,*) j, part(j)
enddo

refpart = [3,1,1,2,4,3,4,2,2,4,3,1,1,2,4]

if(any(part/=refpart)) error stop 'metis failed to order'

end program Mtest
