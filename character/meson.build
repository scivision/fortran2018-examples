ascii = executable('ascii', 'ascii.f90')
test('Ascii Special', ascii, suite: 'char', timeout: 10)

char_array = executable('character_array', 'character_array.f90')
test('CharacterArray', char_array, suite: 'char', timeout: 10)

char_alloc = executable('character_allocatable', 'character_allocatable.f90')
test('CharacterAllocatable', char_alloc, suite: 'char', timeout: 10)

split = executable('split', 'split_string.f90')
test('Split Character', split, suite: 'char', timeout: 10)

printorwrite = executable('printorwrite', 'print_vs_write.f90')
test('UTF8', printorwrite, suite: 'char', timeout: 10)

str2int = executable('str2int', 'str2int.f90')
test('Str2Int', str2int, suite: 'char', timeout: 10)

special_char = executable('special_char', 'special_characters.f90')
test('Special Characters', special_char, suite: 'char', timeout: 10)

charlen = executable('charlen', 'charlen.f90')
test('Character Len', charlen, suite: 'char', timeout: 10)

overwrite_stdout = executable('overwrite_stdout', 'overwrite_stdout.f90',
  link_with: sleep_std)
test('Overwrite Stdout', overwrite_stdout, suite: 'char', timeout: 10)
