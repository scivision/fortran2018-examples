# -- compiler feature checks BEFORE setting flags to avoid intermittant failures in general

if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-traceback;-heap-arrays>"
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-warn;-debug;-check>"
  )

  if(WIN32)
    add_compile_options($<$<CONFIG:Debug>:/Od>)
  else()
    add_compile_options($<$<CONFIG:Debug>:-O0>)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

  add_compile_options(
  $<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Release>>:-fno-backtrace;-Wno-maybe-uninitialized>"
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-Wall;-fcheck=all;-Werror=array-bounds>"
  )

#   "$<$<COMPILE_LANGAUGE:Fortran>:-Wrealloc-lhs>"  # not -Wrealloc-lhs-all which warns on character
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "NAG")
  # https://support.nag.com/nagware/np/r71_doc/manual/compiler_2_4.html#OPTIONS
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-f2018;-C;-colour;-gline;-nan;-info;-u>"
  )
endif()
