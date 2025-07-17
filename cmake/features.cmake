set(j "{}")

foreach(s IN LISTS f2003features f2008features f2018features f2023features)
  string(REPLACE ".cmake" "" s ${s})
  foreach(f IN LISTS s)
    if(${f})
      set(hasf true)
    else()
      set(hasf false)
    endif()

    string(JSON j SET ${j} ${f} ${hasf})
  endforeach()
endforeach()


string(JSON j SET ${j} compiler "{}")
string(JSON j SET ${j} compiler vendor \"${CMAKE_Fortran_COMPILER_ID}\")
string(JSON j SET ${j} compiler version \"${CMAKE_Fortran_COMPILER_VERSION}\")
string(JSON j SET ${j} compiler flags \"${CMAKE_Fortran_FLAGS}\")

string(JSON j SET ${j} platform "{}")
string(JSON j SET ${j} platform system \"${CMAKE_SYSTEM_NAME}\")
string(JSON j SET ${j} platform system_version \"${CMAKE_SYSTEM_VERSION}\")
string(JSON j SET ${j} platform target_arch \"${CMAKE_SYSTEM_PROCESSOR}\")
string(JSON j SET ${j} platform sysroot \"${CMAKE_OSX_SYSROOT}\")

set(feature_file ${CMAKE_CURRENT_BINARY_DIR}/features.json)

file(WRITE ${feature_file} ${j})

message(STATUS "See ${feature_file} for features enabled")
