# -- compiler feature checks BEFORE setting flags to avoid intermittant failures in general

if(CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  add_compile_options(-traceback -heap-arrays
  "$<$<CONFIG:Debug,RelWithDebInfo>:SHELL:-warn all;SHELL:-debug all;SHELL:-check all>"
  )
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

  add_compile_options(
  $<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>
  "$<$<CONFIG:Release>:-fno-backtrace;-Wno-maybe-uninitialized>"
  "$<$<CONFIG:Debug,RelWithDebInfo>:-Wall;-fcheck=all;-Werror=array-bounds>"
  )

#   "$<$<COMPILE_LANGAUGE:Fortran>:-Wrealloc-lhs>"  # not -Wrealloc-lhs-all which warns on character
endif()
