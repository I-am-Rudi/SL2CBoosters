# FindMPFR.cmake
find_path(MPFR_INCLUDE_DIR mpfr.h)
find_library(MPFR_LIBRARY NAMES mpfr libmpfr)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MPFR DEFAULT_MSG
    MPFR_LIBRARY MPFR_INCLUDE_DIR)

if(MPFR_FOUND AND NOT TARGET MPFR::MPFR)
    add_library(MPFR::MPFR UNKNOWN IMPORTED)
    set_target_properties(MPFR::MPFR PROPERTIES
        IMPORTED_LOCATION "${MPFR_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${MPFR_INCLUDE_DIR}")
endif()
