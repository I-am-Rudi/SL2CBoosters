# --------------------------- wigxjpf --------------

add_library(
    wigxjpf
    prime_factor.c
    calc.c
    trivial_zero.c
    c_wrap.c
    fortran_wrap.c
    wigxjpf_error.c
)

add_library(wigxjpf::wigxjpf ALIAS wigxjpf)

target_link_libraries(
    wigxjpf
    PUBLIC
    m
)

target_compile_definitions(
    wigxjpf
    PRIVATE
    ${WIGXJPF_AUTO_CONFIG_DEFINITIONS}
)

target_include_directories(
    wigxjpf
    PUBLIC
    $<BUILD_INTERFACE:${WIGXJPF_ROOT_DIR}/inc>
    $<INSTALL_INTERFACE:include>
    PRIVATE
    "${WIGXJPF_ROOT_DIR}/cfg"
)

target_compile_options(
    wigxjpf
    PRIVATE
    -Wall
    -Wextra
    -Wconversion
    -Wcast-qual
    -O3
)

set_target_properties(
    wigxjpf
    PROPERTIES
    POSITION_INDEPENDENT_CODE True
)

list(
    APPEND
    installable_libs
    wigxjpf
)

list(
    APPEND
    installable_headers
    ${WIGXJPF_ROOT_DIR}/inc/wigxjpf.h
)

# --------------------------- wigxjpf_quadmath --------------

if(HAS_FLOAT128)
    add_library(
        wigxjpf_quadmath
        calc_float128.c
        c_wrap_float128.c
    )

    add_library(wigxjpf::wigxjpf_quadmath ALIAS wigxjpf_quadmath)

    target_link_libraries(
        wigxjpf_quadmath
        PUBLIC
        wigxjpf
        m
        quadmath
    )

    target_compile_definitions(
        wigxjpf_quadmath
        PRIVATE
        ${WIGXJPF_AUTO_CONFIG_DEFINITIONS}
    )

    target_include_directories(
        wigxjpf_quadmath
        PUBLIC
        $<BUILD_INTERFACE:${WIGXJPF_ROOT_DIR}/inc>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        "${WIGXJPF_ROOT_DIR}/cfg"
    )

    target_compile_options(
        wigxjpf_quadmath
        PRIVATE
        -Wall
        -Wextra
        -Wconversion
        -Wcast-qual
        -O3
    )

    set_target_properties(
        wigxjpf_quadmath
        PROPERTIES
        POSITION_INDEPENDENT_CODE True
    )

    list(
        APPEND
        installable_libs
        wigxjpf_quadmath
    )

    list(
        APPEND
        installable_headers
        ${WIGXJPF_ROOT_DIR}/inc/wigxjpf_quadmath.h
    )
endif()

install(TARGETS ${installable_libs}
    EXPORT wigxjpf-targets
    DESTINATION lib
)
install(
    FILES ${installable_headers}
    DESTINATION include
)