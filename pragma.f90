! support for this in ifort coming 2017H2
! https://software.intel.com/en-us/forums/intel-visual-fortran-compiler-for-windows/topic/560114?language=ru
program procprint

use,intrinsic:: iso_fortran_env

print *,compiler_version(),compiler_options()



end program
