# FindGMP.cmake
find_path(GMP_INCLUDE_DIR gmp.h)
find_library(GMP_LIBRARY NAMES gmp libgmp)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GMP DEFAULT_MSG
    GMP_LIBRARY GMP_INCLUDE_DIR)

if(GMP_FOUND AND NOT TARGET GMP::GMP)
    add_library(GMP::GMP UNKNOWN IMPORTED)
    set_target_properties(GMP::GMP PROPERTIES
        IMPORTED_LOCATION "${GMP_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${GMP_INCLUDE_DIR}")
endif()
