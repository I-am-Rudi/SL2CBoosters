add_library(wigxjpf_config INTERFACE)
target_compile_definitions(
    wigxjpf_config
    INTERFACE
    ${WIGXJPF_AUTO_CONFIG_DEFINTIONS}
)
target_include_directories(
    wigxjpf_config
    INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
