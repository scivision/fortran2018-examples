# run a CTest test using a file piped to stdin
execute_process(
COMMAND ${tgt}
INPUT_FILE ${txt}
RESULT_VARIABLE ret
)

if(NOT ret EQUAL 0)
  message(FATAL_ERROR "${tgt}  return code ${ret}")
endif()
