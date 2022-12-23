program utf8_char
!! demo UTF8 characters in Fortran
!! if characters print garbled, ensure UTF8 is enabled in your system locale.
!! this is also true for Windows, which will work in PowerShell once UTF8 is enabled

implicit none

character(:), allocatable :: ascii
character(len=:, kind=selected_char_kind('ISO_10646')), allocatable :: utf8

ascii = '☀ ☁ ☂ ☃ ☄'
utf8 = '☀ ☁ ☂ ☃ ☄'

print *, 'ascii', ascii, ' some compilers allow UTF-8 to be packed into ASCII per Fortran 2003 standard (optional)'
print *, 'utf8', utf8, ' this is 4-byte characters.'

end program
