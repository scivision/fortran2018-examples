
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# https://wg5-fortran.org/N2201-N2250/N2212.pdf
# section 9.3

check_source_compiles(Fortran "program test
 enum, bind(c) :: season
 enumerator :: spring=5, summer=7, autumn, winter
 end enum
 type(season) my_season
 end program"
 f2023enum)
