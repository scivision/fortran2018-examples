program utf8_char
!! demo UTF8 characters in Fortran
!! if characters print garbled, ensure UTF8 is enabled in your system locale.
!! this is also true for Windows, which will work in PowerShell once UTF8 is enabled

implicit none

character(:), allocatable :: ascii
character(len=:, kind=selected_char_kind('ISO_10646')), allocatable :: utf8

ascii = '☀ ☁ ☂ ☃ ☄'
utf8  = '☀ ☁ ☂ ☃ ☄'

print '(a)', 'ASCII:'
print '(a)', ascii

print '(a)', 'UCS4:'
print '(a)', utf8

end program
