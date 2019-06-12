os = host_machine.system()

ascii = executable('ascii', 'ascii.f90')
test('Ascii Special', ascii)

split = executable('split', 'split_string.f90')
test('Split Character', split)

printorwrite = executable('printorwrite', 'print_vs_write.f90')
test('UTF8', printorwrite)

str2int = executable('str2int', 'str2int.f90')
test('Str2Int', str2int)

special_char = executable('special_char', 'special_characters.f90')
test('Special Characters', special_char)

charlen = executable('charlen', 'charlen.f90')
test('Character Len', charlen)

if os != 'windows'
  overwrite_stdout = executable('overwrite_stdout', 'overwrite_stdout.f90')
  test('Overwrite Stdout', overwrite_stdout)
endif