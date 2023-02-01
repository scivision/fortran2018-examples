set_property(DIRECTORY PROPERTY LABELS real)

if(NOT realbits)
  set(realbits 64)
endif()

set(real_prec "integer,parameter :: wp=real${realbits}")

foreach(t IN ITEMS array_real cast_int2real)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

if(f03ieee)
  add_executable(test_assert finite.f90 ${PROJECT_SOURCE_DIR}/src/real/assert.f90)
  add_test(NAME assert COMMAND test_assert)
endif()

configure_file(${PROJECT_SOURCE_DIR}/src/real/polymorphic.in.f90 polymorphic.f90 @ONLY)
add_executable(polymorph ${CMAKE_CURRENT_BINARY_DIR}/polymorphic.f90)
add_test(NAME polymorphic COMMAND polymorph)

if(f03ieee)
  add_executable(epsilon epsilon.f90)
  add_test(NAME epsilon COMMAND epsilon)

  add_executable(nan nans.f90)
  add_test(NAME NaN COMMAND nan)
endif()

add_executable(coerce coerce.F90)
target_compile_definitions(coerce PRIVATE $<$<BOOL:${f08kind}>:r128>)
add_test(NAME coerce COMMAND coerce)

add_executable(divprec div_precision.F90)
target_compile_definitions(divprec PRIVATE $<$<BOOL:${f08kind}>:r128>)
add_test(NAME divisionPrecision COMMAND divprec)

add_executable(floatprec floating_precision.F90)
target_compile_definitions(floatprec PRIVATE $<$<BOOL:${f08kind}>:r128>)
add_test(NAME floatPrecision COMMAND floatprec)

add_executable(hugeprec huge_precision.F90)
target_compile_definitions(hugeprec PRIVATE $<$<BOOL:${f08kind}>:r128>)
add_test(NAME hugePrecision COMMAND hugeprec)

add_executable(precprob precision_problems.f90)
add_test(NAME precisionProblems COMMAND precprob)


if(f08kind)
  add_executable(nan_128 nans_128.f90)
  add_test(NAME NaN128 COMMAND nan_128)
endif()

if(f18prop)
  add_executable(properties properties.f90)
  add_test(NAME properties COMMAND properties)
endif()
