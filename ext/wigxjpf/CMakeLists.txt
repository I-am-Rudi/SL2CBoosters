cmake_minimum_required(VERSION 3.10)

project(
    WIGXJPF
    VERSION
    1.11
)

option(WIGXJPF_BUILD_BINARIES "Build binaries" OFF)

# Determine if WIGXJPF is built as a subproject (using add_subdirectory)
# or if it is the main project.
if(NOT DEFINED WIGXJPF_MAIN_PROJECT)
  set(WIGXJPF_MAIN_PROJECT OFF)
  if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(WIGXJPF_MAIN_PROJECT ON)
    message(STATUS "CMake version: ${CMAKE_VERSION}")
  endif()
endif()

# Set the default CMAKE_BUILD_TYPE to Release.
# This should be done before the project command since the latter can set
# CMAKE_BUILD_TYPE itself (it does so for nmake).
if(WIGXJPF_MAIN_PROJECT AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

if(WIGXJPF_MAIN_PROJECT)
  add_compile_options("-Wall" "-Wextra" "-Werror" "$<$<CONFIG:RELEASE>:-O3>")
endif()

set(WIGXJPF_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})


include(cmake/AutoConfigureWIGXJPF.cmake)
add_subdirectory(cfg)
add_subdirectory(src)
if(WIGXJPF_BUILD_BINARIES)
  find_package(OpenMP REQUIRED)
  add_subdirectory(example)
endif()

install(
    EXPORT wigxjpf-targets
    FILE wigxjpf-targets.cmake
    DESTINATION lib/cmake/wigxjpf
)

include(CMakePackageConfigHelpers)
# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/wigxjpf-config.cmake"
    INSTALL_DESTINATION "lib/cmake/example"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/wigxjpf-config-version.cmake"
    VERSION "${WIGXJPF_VERSION_MAJOR}.${WIGXJPF_VERSION_MINOR}"
    COMPATIBILITY AnyNewerVersion
)
install(
    FILES
    ${CMAKE_CURRENT_BINARY_DIR}/wigxjpf-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/wigxjpf-config-version.cmake
    DESTINATION lib/cmake/wigxjpf
)

include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING.LESSER")
set(CPACK_PACKAGE_VERSION_MAJOR "${WIGXJPF_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${WIGXJPF_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "ZIP")
include(CPack)
