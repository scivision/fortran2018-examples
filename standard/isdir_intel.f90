submodule (std_mkdir) isdir

contains

module procedure is_directory
inquire(directory=path, exist=is_directory)
end procedure is_directory

end submodule isdir