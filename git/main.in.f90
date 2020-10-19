program git_demo
!! we don't make porcelain a character because it could go beyond max fortran line length
implicit none (type, external)

character(:), allocatable :: git_version, branch, rev
logical :: porcelain

git_version = "@git_version@"
branch = "@git_branch@"
rev = "@git_rev@"
porcelain = @git_porcelain@

print *, "MyProgram  git_version:", git_version, " git_branch: ", branch, " git revision: ", rev, ' git_porcelain', porcelain
!! could also use this to set a warning or other logical flag

end program
