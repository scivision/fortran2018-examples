ascii = executable('ascii', 'ascii.f90')
test('Ascii Special', ascii,
  timeout: 10)

split = executable('split', 'split_string.f90')
test('Split Character', split,
  timeout: 10)

printorwrite = executable('printorwrite', 'print_vs_write.f90')
test('UTF8', printorwrite,
  timeout: 10)

str2int = executable('str2int', 'str2int.f90')
test('Str2Int', str2int,
  timeout: 10)

special_char = executable('special_char', 'special_characters.f90')
test('Special Characters', special_char,
  timeout: 10)

charlen = executable('charlen', 'charlen.f90')
test('Character Len', charlen,
  timeout: 10)

if os != 'windows'
  overwrite_stdout = executable('overwrite_stdout', 'overwrite_stdout.f90')
  test('Overwrite Stdout', overwrite_stdout, timeout: 10)
endif