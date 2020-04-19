submodule (random) randinit

implicit none (type, external)

contains

module procedure rand_init

call random_init(repeatable, image_distinct)

end procedure rand_init

end submodule randinit
