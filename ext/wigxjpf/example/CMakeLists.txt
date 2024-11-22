add_executable(ccsimple ccsimple.cc)
target_link_libraries(ccsimple wigxjpf)
target_include_directories(ccsimple PRIVATE ${WIGXJPF_ROOT_DIR}/inc)

add_executable(cfail cfail.c)
target_link_libraries(cfail wigxjpf)
target_include_directories(cfail PRIVATE ${WIGXJPF_ROOT_DIR}/inc)

add_executable(cthreadedsimple cthreadedsimple.c)
target_link_libraries(cthreadedsimple wigxjpf OpenMP::OpenMP_C)
target_include_directories(cthreadedsimple PRIVATE ${WIGXJPF_ROOT_DIR}/inc)

add_executable(wigxjpf_bin wigxjpf.c)
target_link_libraries(wigxjpf_bin wigxjpf)
target_include_directories(wigxjpf_bin PRIVATE ${WIGXJPF_ROOT_DIR}/inc)
set_target_properties(wigxjpf_bin PROPERTIES OUTPUT_NAME wigxjpf)
