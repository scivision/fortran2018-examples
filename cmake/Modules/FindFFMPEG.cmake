# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindFFMPEG
---------

Finds the FFMPEG library.
Assumes path to ffmpeg binary is in PATH or FFMPEG_ROOT

COMPONENTS
  EXECUTABLE  FFMPEG main program

  PLAY  ffplay  program

  PROBE ffprobe  program

Result Variables
^^^^^^^^^^^^^^^^

FFMPEG_FFMPEG
  main ffmpeg executable

FFMPEG_FFPLAY
  ffplay executable

FFMPEG_FFPROBE
  ffprobe executable


#]=======================================================================]

cmake_policy(VERSION 3.3)

if(NOT FFMPEG_FIND_COMPONENTS)
  set(FFMPEG_FIND_COMPONENTS EXECUTABLE)
endif()


find_program(FFMPEG_FFMPEG
          NAMES ffmpeg
          DOC "FFmpeg main executable")
if(FFMPEG_FFMPEG)
  set(FFMPEG_EXECUTABLE_FOUND true)
endif()

if(PROBE IN_LIST FFMPEG_FIND_COMPONENTS)
  find_program(FFMPEG_FFPROBE
              NAMES ffprobe
              DOC "FFprobe main executable")

  if(FFMPEG_FFPROBE)
    set(FFMPEG_PROBE_FOUND true)
  endif()
endif()


if(PLAY IN_LIST FFMPEG_FIND_COMPONENTS)
  find_program(FFMPEG_FFPLAY
              NAMES ffplay
              DOC "FFplay main executable")

  if(FFMPEG_FFPLAY)
    set(FFMPEG_PLAY_FOUND true)
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFMPEG
  REQUIRED_VARS FFMPEG_FFMPEG
  HANDLE_COMPONENTS)
