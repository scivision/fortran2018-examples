set(CMAKE_EXPORT_COMPILE_COMMANDS on)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "use cmake -B build or similar to avoid building in-source, which is messy")
endif()

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.20)
  # explicit source file extensions
  cmake_policy(SET CMP0115 NEW)
endif()
if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.19)
  # make missing imported targets fail immediately
  cmake_policy(SET CMP0111 NEW)
endif()
if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.18)
  # saner ALIAS target policies
  cmake_policy(SET CMP0107 NEW)
  cmake_policy(SET CMP0108 NEW)
endif()
if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.17)
  cmake_policy(SET CMP0099 NEW)
endif()
