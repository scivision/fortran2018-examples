set_directory_properties(PROPERTIES LABELS random)

add_executable(random random.f90 random_demo.f90
$<IF:$<BOOL:${f18random}>,random_init_f2018.f90,random_init.f90>
)
add_test(NAME RandomInit COMMAND random)
