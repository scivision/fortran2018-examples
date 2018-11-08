# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
find_package(MKL)
if(MKL_FOUND)
    set(MKLROOT $ENV{MKLROOT})
    include_directories(${MKL_INCLUDE_DIRS} ${MKLROOT}/include/intel64/lp64)
    
    find_package(Threads REQUIRED QUIET)

    set(FLIBS mkl_blas95_lp64 mkl_lapack95_lp64 mkl_gf_lp64 mkl_tbb_thread mkl_core tbb stdc++ ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS} m)
endif()
