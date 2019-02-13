# based on: https://github.com/Kitware/VTK/blob/master/CMake/FindNetCDF.cmake
find_path(NetCDF_INCLUDE_DIR
  NAMES netcdf.h
  DOC "NetCDF include directories")
mark_as_advanced(NetCDF_INCLUDE_DIR)

find_library(NetCDF_C_LIBRARY
  NAMES netcdf
  DOC "NetCDF C library")
mark_as_advanced(NetCDF_C_LIBRARY)

find_library(NetCDF_Fortran_LIBRARY
  NAMES netcdff
  DOC "NetCDF Fortran library")
mark_as_advanced(NetCDF_Fortran_LIBRARY)

set(NetCDF_LIBRARY ${NetCDF_Fortran_LIBRARY} ${NetCDF_C_LIBRARY})
mark_as_advanced(NetCDF_LIBRARY)

if (NetCDF_INCLUDE_DIR)
  file(STRINGS "${NetCDF_INCLUDE_DIR}/netcdf_meta.h" _netcdf_version_lines
    REGEX "#define[ \t]+NC_VERSION_(MAJOR|MINOR|PATCH|NOTE)")
  string(REGEX REPLACE ".*NC_VERSION_MAJOR *\([0-9]*\).*" "\\1" _netcdf_version_major "${_netcdf_version_lines}")
  string(REGEX REPLACE ".*NC_VERSION_MINOR *\([0-9]*\).*" "\\1" _netcdf_version_minor "${_netcdf_version_lines}")
  string(REGEX REPLACE ".*NC_VERSION_PATCH *\([0-9]*\).*" "\\1" _netcdf_version_patch "${_netcdf_version_lines}")
  string(REGEX REPLACE ".*NC_VERSION_NOTE *\"\([^\"]*\)\".*" "\\1" _netcdf_version_note "${_netcdf_version_lines}")
  set(NetCDF_VERSION "${_netcdf_version_major}.${_netcdf_version_minor}.${_netcdf_version_patch}${_netcdf_version_note}")
  unset(_netcdf_version_major)
  unset(_netcdf_version_minor)
  unset(_netcdf_version_patch)
  unset(_netcdf_version_note)
  unset(_netcdf_version_lines)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NetCDF
  REQUIRED_VARS NetCDF_LIBRARY NetCDF_INCLUDE_DIR
  VERSION_VAR NetCDF_VERSION)

if(NetCDF_FOUND)
  set(NetCDF_INCLUDE_DIRS ${NetCDF_INCLUDE_DIR})
  set(NetCDF_LIBRARIES ${NetCDF_LIBRARY})

  if(NOT TARGET NetCDF::NetCDF_C)
    add_library(NetCDF::NetCDF_C UNKNOWN IMPORTED)
    set_target_properties(NetCDF::NetCDF_C PROPERTIES
      IMPORTED_LOCATION ${NetCDF_C_LIBRARY}
      INTERFACE_INCLUDE_DIRECTORIES ${NetCDF_INCLUDE_DIR})
  endif()

  if(NOT TARGET NetCDF::NetCDF_Fortran)
    add_library(NetCDF::NetCDF_Fortran UNKNOWN IMPORTED)
    set_target_properties(NetCDF::NetCDF_Fortran PROPERTIES
      IMPORTED_LOCATION ${NetCDF_Fortran_LIBRARY}
      INTERFACE_INCLUDE_DIRECTORIES ${NetCDF_INCLUDE_DIR})
  endif()
endif ()
