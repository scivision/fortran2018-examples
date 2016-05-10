module splitstring
    implicit none
contains
! split a string about a delimiter token, return part before delim
!
! with regard to length of CHARACTER, it's probably best to pick a length longer than you'll need
! and trim rather than using assumed size, particularly if interfacing with other languages
! CHARACTER assumed size seems to work, but is not reliable in diverse enviroments.
! Your time is more valueable than a few bytes of RAM.
character(len=80)  function split(instr,  delm)

        character(len=*), intent(in) :: instr
        character(len=1), intent(in) :: delm

        integer  idx

        idx = scan(instr,delm)
        split = instr(1:idx-1)

    end function split

end module splitstring
!---------------------------------------
program demosplit

    use, intrinsic :: iso_fortran_env, only : stdin=>input_unit
    use splitstring

    character(len=*),parameter :: mystr="hello.txt"
    character(len=80) stem

    stem = split(mystr,'.')
    print *, stem



end program



