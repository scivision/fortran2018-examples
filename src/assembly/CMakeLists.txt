# N*N is faster than N**2 if the compiler can't optimize away constants.
# Howver, contemporary compilers typically optimize integer powers
# Floating-point powers are handled the "slow" way

cmake_minimum_required(VERSION 3.14)
project(assemblyOut LANGUAGES C Fortran)

include(asm.cmake)

c2asm(c_multiply c_multiply.c)
c2asm(c_power c_power.c)
f2asm(f_multiply f_multiply.f90)
