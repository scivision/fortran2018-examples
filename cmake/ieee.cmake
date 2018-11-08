function(ieeedemos FFLAGS)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU AND ${CMAKE_Fortran_COMPILER_VERSION} VERSION_LESS 6)
  return()
endif()


  
endfunction()

ieeedemos(${FFLAGS})
