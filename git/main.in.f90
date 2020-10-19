program git_demo

implicit none (type, external)

character(:), allocatable :: git_version, branch, rev, porcelain

git_version = "@git_version@"
branch = "@git_branch@"
rev = "@git_rev@"
porcelain = "@git_porcelain@"

print *, "MyProgram  git_version:", git_version, " git_branch: ", branch, " git revision: ", rev

if (len(porcelain) > 0) print *, " git_porcelain:", porcelain
!! could also use this to set a warning or other logical flag

end program
