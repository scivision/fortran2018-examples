# -- compiler feature checks BEFORE setting flags to avoid intermittant failures in general

if(CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  add_compile_options(
    "$<$<COMPILE_LANGUAGE:Fortran>:-traceback;-heap-arrays>"
    "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-warn:all>"
    "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-debug:all>"
    # "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-check:all>"  # nuisance runtime array temporary
  )
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none;-Werror=line-truncation>"
    "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Release>>:-fno-backtrace;-Wno-maybe-uninitialized>"
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-Wall;-fcheck=all;-Werror=array-bounds>"
  )

#   "$<$<COMPILE_LANGUAGE:Fortran>:-Wrealloc-lhs>"  # not -Wrealloc-lhs-all which warns on character
endif()
