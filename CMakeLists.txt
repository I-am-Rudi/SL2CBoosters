cmake_minimum_required(VERSION 3.10)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

project(SL2CBoosters C)

include(ExternalProject)

# Options
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(USE_OPENMP "Use OpenMP for parallelization" ON)
option(USE_JULIA "Build with Julia support" OFF)

# Find dependencies
if(USE_JULIA)
    find_package(Julia)
endif()
find_package(GMP REQUIRED)
find_package(MPFR REQUIRED)
find_package(MPC REQUIRED)
if(USE_OPENMP)
    find_package(OpenMP REQUIRED)
endif()

# Set compile flags
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_compile_options(-fPIC -march=native -fno-math-errno)
if(USE_OPENMP)
    add_compile_options(${OpenMP_C_FLAGS})
endif()

# Build wigxjpf first
add_subdirectory(ext/wigxjpf)

# Library sources
set(SL2CBOOSTERS_SOURCES
    src/c/b4.c
    src/c/boosters.c
    src/c/cgamma.c
    src/c/dsmall.c
    src/c/sl2cfoam.c
    src/c/setup.c
    src/c/integration_gk.c
)

# Create library
add_library(sl2cboosters ${SL2CBOOSTERS_SOURCES})

# Include directories
target_include_directories(sl2cboosters
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/c>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/ext/wigxjpf/inc
)

if(USE_JULIA AND Julia_FOUND)
    target_include_directories(sl2cboosters PRIVATE ${Julia_INCLUDE_DIRS})
    target_link_libraries(sl2cboosters PRIVATE ${Julia_LIBRARIES})
endif()

# Link dependencies
target_link_libraries(sl2cboosters
    PRIVATE
        wigxjpf
        GMP::GMP
        MPFR::MPFR
        MPC::MPC
        quadmath
)

if(USE_OPENMP)
    target_link_libraries(sl2cboosters PRIVATE OpenMP::OpenMP_C)
endif()

# Installation
include(GNUInstallDirs)

# Install wigxjpf library and headers
install(FILES 
    $<TARGET_FILE:wigxjpf>
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/ext/wigxjpf/inc/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING PATTERN "*.h"
)

install(TARGETS sl2cboosters
    EXPORT SL2CBoosters-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install headers
install(FILES 
    src/c/boosters.h
    src/c/sl2cfoam.h
    src/c/sl2cfoam_tensors.h
    src/c/utils.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sl2cboosters
)

# Export targets
install(EXPORT SL2CBoosters-targets
    FILE SL2CBoostersTargets.cmake
    NAMESPACE SL2CBoosters::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/SL2CBoosters
)
