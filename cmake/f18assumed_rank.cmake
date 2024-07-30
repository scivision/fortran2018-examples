set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

check_source_compiles(Fortran "subroutine r(A)
integer, intent(inout) :: A(..)
select rank(A)
  rank default
    error stop
end select
end subroutine r
"
f18assumed_rank
)
