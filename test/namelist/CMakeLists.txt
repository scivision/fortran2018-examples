set_property(DIRECTORY PROPERTY LABELS namelist)

add_executable(namelist ${PROJECT_SOURCE_DIR}/app/namelist/namelist.f90)
add_test(NAME NamelistRead COMMAND namelist
WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/app/namelist
)
