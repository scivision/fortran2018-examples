module mytest
    use, intrinsic:: iso_c_binding, only: dp=>C_DOUBLE, c_int

    Implicit none

contains
   
    subroutine yourmsg(z,N)

    real(dp),intent(in) :: z(N)
    integer(c_int), intent(in) :: N

    integer :: i
    
    print *,sqrt(z)

    end subroutine yourmsg


end module mytest
