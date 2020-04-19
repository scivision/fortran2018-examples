submodule (pathlib) path_exists
!! Intel compilers require non-standard inquire(directory=)
implicit none (type, external)

contains

module procedure assert_directory_exists
!! throw error if directory does not exist
!! this accomodates non-Fortran 2018 error stop with variable character

logical :: exists

inquire(directory=path, exist=exists)

if (exists) return

write(stderr,*) path // ' directory does not exist'
error stop

end procedure assert_directory_exists

end submodule path_exists