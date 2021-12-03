subroutine unlink(filename)
!! deletes file in Fortran standard manner.
!! Silently continues if file doesn't exist or cannot be deleted.
!! the GNU extension unlink() is non-standard and crashes ifort runtimes.
character(*), intent(in) :: filename
integer :: i, u

open(newunit=u, file=filename, iostat=i)
close(u, status='delete', iostat=i)

end subroutine unlink
