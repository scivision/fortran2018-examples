ascii = executable('ascii', 'ascii.f90')
test('Ascii Special', ascii, suite: 'char')

char_array = executable('character_array', 'character_array.f90')
test('CharacterArray', char_array, suite: 'char')

char_alloc = executable('character_allocatable', 'character_allocatable.f90')
test('CharacterAllocatable', char_alloc, suite: 'char')

split = executable('split', 'split_string.f90')
test('Split Character', split, suite: 'char')

if f03utf8
utf8 = executable('utf8', 'utf8.f90')
test('utf8', utf8, suite: 'char')
else
message('SKIP: UTF8')
endif

printorwrite = executable('printorwrite', 'print_vs_write.f90')
test('print_utf8', printorwrite, suite: 'char')

str2int = executable('str2int', 'str2int.f90')
test('Str2Int', str2int, suite: 'char')

special_char = executable('special_char', 'special_characters.f90')
test('Special Characters', special_char, suite: 'char')

charlen = executable('charlen', 'charlen.f90')
test('Character Len', charlen, suite: 'char')

overwrite_stdout = executable('overwrite_stdout', 'overwrite_stdout.f90',
  link_with: sleep_std)
test('Overwrite Stdout', overwrite_stdout, suite: 'char', timeout: 10)

string_utils = executable('string_utils', 'string_utils.f90', 'test_string.f90')
test('utils', string_utils, suite: 'char')
