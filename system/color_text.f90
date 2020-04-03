program color_text
!! This program demonstrates color text output to terminal from Fortran program.
!! It uses ANSI escape codes and also works on modern Windows consoles.
!! It is compatible across compiler vendors.
!!
!! More colors: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

use, intrinsic :: iso_fortran_env, only: stderr=>error_unit
implicit none (external)

character, parameter :: e = char(27) !< escape

character(5), parameter :: &
  red =    e // '[31m', &
  yellow = e // '[33m', &
  normal = e // '[0m'

print *, red // 'this is red text to stdout' // normal // ' this is regular text to stdout'
write(stderr,*) red // 'this is red text to stderr' // normal // ' this is regular text to stderr'

print *, yellow // 'this is yellow on stdout'
print *, 'this stdout is also yellow because the prior statement did not set normal'

write(stderr,*) 'stderr is also yellow.'
end program
