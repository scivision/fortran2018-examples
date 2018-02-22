! https://github.com/JuliaLang/julia/blob/master/test/perf/micro/perf.f90
module perf
  use, intrinsic :: iso_fortran_env
  implicit none
  include 'kind.txt' ! output by CMake
  private
  
  public :: wp, sysclock2ms, init_random_seed, assert
  
contains

real(wp) function sysclock2ms(t)
! Convert a number of clock ticks, as returned by system_clock called
! with integer(i64) arguments, to milliseconds

  integer(int64), intent(in) :: t
  integer(int64) :: rate
  real(wp) ::  r
  call system_clock(count_rate=rate)
  r = 1000._wp / rate
  sysclock2ms = t * r
end function sysclock2ms


subroutine init_random_seed()

  integer :: i, n, clock
  integer, allocatable :: seed(:)

  call random_seed(size=n)
  allocate(seed(n))
  call system_clock(count=clock)
  seed = clock + 37 * [ (i - 1, i = 1, n) ]
  call random_seed(put=seed)
end subroutine


subroutine assert(cond)
    logical, intent(in) :: cond

    if (.not. cond) then
        error stop 'assertion failed, halting test'
    end if

end subroutine assert

End Module perf
