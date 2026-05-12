# -- compiler feature checks BEFORE setting flags to avoid intermittant failures in general

if(CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  add_compile_options(-traceback -heap-arrays
  "$<$<CONFIG:Debug,RelWithDebInfo>:SHELL:-warn all;SHELL:-debug all;SHELL:-check all>"
  )
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none;-Werror=line-truncation>"
  "$<$<CONFIG:Release>:-fno-backtrace;-Wno-maybe-uninitialized>"
  "$<$<CONFIG:Debug,RelWithDebInfo>:-Wall;-fcheck=all;-Werror=array-bounds>"
  )

#   "$<$<COMPILE_LANGUAGE:Fortran>:-Wrealloc-lhs>"  # not -Wrealloc-lhs-all which warns on character
endif()
