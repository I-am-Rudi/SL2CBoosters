# Try to find the MPC library
# Once done this will define
#  MPC_FOUND - System has MPC
#  MPC_INCLUDE_DIRS - The MPC include directories
#  MPC_LIBRARIES - The libraries needed to use MPC

find_path(MPC_INCLUDE_DIR
    NAMES mpc.h
    PATHS
        /usr/include
        /usr/local/include
        /opt/local/include
        /sw/include
        ${MPC_DIR}/include
)

find_library(MPC_LIBRARY
    NAMES mpc libmpc
    PATHS
        /usr/lib
        /usr/lib/x86_64-linux-gnu
        /usr/local/lib
        /opt/local/lib
        /sw/lib
        ${MPC_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MPC DEFAULT_MSG
    MPC_LIBRARY MPC_INCLUDE_DIR)

mark_as_advanced(MPC_INCLUDE_DIR MPC_LIBRARY)

if(MPC_FOUND)
    set(MPC_LIBRARIES ${MPC_LIBRARY})
    set(MPC_INCLUDE_DIRS ${MPC_INCLUDE_DIR})
endif()

# Create an imported target
if(MPC_FOUND AND NOT TARGET MPC::MPC)
    add_library(MPC::MPC UNKNOWN IMPORTED)
    set_target_properties(MPC::MPC PROPERTIES
        IMPORTED_LOCATION "${MPC_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${MPC_INCLUDE_DIR}"
    )
endif()
