if(NOT realbits)
  set(realbits 64)
endif()

add_executable(polymorph polymorphic.F90)
target_compile_definitions(polymorph PRIVATE REALBITS=${realbits})
add_test(NAME Polymorphic COMMAND polymorph)


add_executable(divprec div_precision.F90)
if(f08kind)
target_compile_definitions(divprec PRIVATE REAL128)
endif()
add_test(NAME DivisionPrecision COMMAND divprec)

add_executable(floatprec floating_precision.F90)
if(f08kind)
target_compile_definitions(floatprec PRIVATE REAL128)
endif()
add_test(NAME FloatPrecision COMMAND floatprec)

add_executable(hugeprec huge_precision.F90)
if(f08kind)
target_compile_definitions(hugeprec PRIVATE REAL128)
endif()
add_test(NAME HugePrecision COMMAND hugeprec)

if(f08kind)
add_executable(precprob precision_problems.f90)
add_test(NAME PrecisionProblems COMMAND precprob)
endif()


if(f18prop)
add_executable(properties properties.f90)
add_test(NAME Fortran2018Properties COMMAND properties)
endif()


if(f03ieee)

add_executable(nan nans.F90)
if(f08kind)
target_compile_definitions(nan PRIVATE REAL128)
endif()
add_test(NAME NaN COMMAND nan)

add_library(assert OBJECT assert.F90)
target_compile_definitions(assert PRIVATE REALBITS=${realbits})

if(f08kind)
add_executable(testassert not-finite.f90 fib3.f90)
target_link_libraries(testassert PRIVATE assert)
add_test(NAME Assert COMMAND testassert)
endif()

endif(f03ieee)
