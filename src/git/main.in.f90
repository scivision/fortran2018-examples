program git_demo
!! we don't make porcelain a character because it could go beyond max fortran line length
implicit none

character(:), allocatable :: git_version, branch, rev
logical :: porcelain

git_version = "@git_version@"
branch = "@git_branch@"
rev = "@git_rev@"
porcelain = @git_porcelain@

print *, "git_version: ", git_version
print *, "git_branch: ", branch
print *, "git revision: ", rev
print *, "git_porcelain ", porcelain
!! could also use this to set a warning or other logical flag

end program
