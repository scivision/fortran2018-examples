
add_executable(random random.f90 random_demo.f90)
add_test(NAME RandomInit COMMAND random)
if(f18random)
  target_sources(random PRIVATE random_init_f2018.f90)
else()
  target_sources(random PRIVATE random_init.f90)
endif()
