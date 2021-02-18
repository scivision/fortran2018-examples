# if(NOT CMAKE_Fortran_COMPILER_ID STREQUAL ${CMAKE_C_COMPILER_ID})
# message(WARNING "C compiler ${CMAKE_C_COMPILER_ID} does not match Fortran compiler ${CMAKE_Fortran_COMPILER_ID}.
# Set environment variables CC and FC to control compiler selection in general.")
# endif()

include(CheckFortranSourceCompiles)

include(${CMAKE_CURRENT_LIST_DIR}/f18impnone.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08contig.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18errorstop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18random.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18assumed_rank.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08kind.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18prop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08command.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f03ieee.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f03utf8.cmake)

# compiler feature checks BEFORE setting flags to avoid intermittant failures in general

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel OR CMAKE_Fortran_COMPILER_ID STREQUAL IntelLLVM)
  if(WIN32)
    add_compile_options(/QxHost)
    string(APPEND CMAKE_Fortran_FLAGS " /traceback /heap-arrays")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " /stand:f18 /warn")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " /debug /check:all")
  else()
    add_compile_options(-xHost)
    string(APPEND CMAKE_Fortran_FLAGS " -traceback -heap-arrays")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -stand f18 -warn")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -debug extended -check all")
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  # add_compile_options(-mtune=native -Wall)
  # if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
  #   string(APPEND CMAKE_Fortran_FLAGS " -std=f2018")
  # endif()

  string(APPEND CMAKE_Fortran_FLAGS " -fimplicit-none")
  # string(APPEND CMAKE_Fortran_FLAGS " -Wrealloc-lhs")  # not -Wrealloc-lhs-all which warns on character
  string(APPEND CMAKE_Fortran_FLAGS " -Werror=array-bounds -fcheck=all")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  # https://www.nag.co.uk/nagware/np/r70_doc/manual/compiler_2_4.html#OPTIONS
  string(APPEND CMAKE_Fortran_FLAGS " -f2018 -C -colour -gline -nan -info -u")
endif()
