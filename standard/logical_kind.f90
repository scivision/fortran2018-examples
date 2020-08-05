program logical_kind
!! normally logical is 4 bytes per element
!! however for special use cases one can specify one byte per logical element
use, intrinsic :: iso_c_binding, only : c_bool

implicit none (type, external)

logical(kind=1) :: byte1
logical(kind=4) :: byte4
logical(kind=c_bool) :: byte_c
logical :: byte_default

if (storage_size(byte1) /= 8) error stop 'logical(kind=1) should be 8 bits'
if (storage_size(byte4) /= 32) error stop 'logical(kind=4) should be 32 bits'
if (storage_size(byte_c) /= 8) error stop 'logical(kind=c_bool) is typically 8 bits'
if (storage_size(byte_default) /= 32) error stop 'logical should be 32 bits'

end program
