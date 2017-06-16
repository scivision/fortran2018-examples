module mytest
    use, intrinsic:: iso_c_binding, only: dp=>c_double, c_int

    Implicit none

contains
   
    subroutine yourmsg(z,N) bind(c)

    real(dp),intent(in) :: z(N)
    integer(c_int), intent(in) :: N

    integer :: i

    print *,'z',z    
    print *,'sqrt(z)',sqrt(z)

    end subroutine yourmsg


end module mytest
