# Find Julia installation
# This module sets the following variables:
# Julia_FOUND - true if Julia is found
# Julia_EXECUTABLE - the path to the Julia executable
# Julia_INCLUDE_DIRS - the Julia include directory
# Julia_LIBRARIES - the Julia libraries
# Julia_MAIN_HEADER - the path to julia.h
# Julia_VERSION_STRING - version string

include(FindPackageHandleStandardArgs)

# Find Julia executable
if(Julia_EXECUTABLE)
    # If the user specified the executable, don't override it
else()
    find_program(Julia_EXECUTABLE julia DOC "Julia executable")
endif()

if(NOT Julia_EXECUTABLE)
    return()
endif()

# Get Julia version
execute_process(
    COMMAND ${Julia_EXECUTABLE} --version
    OUTPUT_VARIABLE Julia_VERSION_STRING
    RESULT_VARIABLE RESULT
)
if(RESULT EQUAL 0)
    string(REGEX REPLACE ".*([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1" Julia_VERSION_STRING "${Julia_VERSION_STRING}")
endif()

# Get Julia binary dir
execute_process(
    COMMAND ${Julia_EXECUTABLE} -e "using Libdl; println(dirname(Libdl.dlpath(\"libjulia\")))"
    OUTPUT_VARIABLE Julia_BINDIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Get Julia include dir
execute_process(
    COMMAND ${Julia_EXECUTABLE} -e "println(dirname(Sys.BINDIR))"
    OUTPUT_VARIABLE Julia_PREFIX
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(Julia_INCLUDE_DIRS ${Julia_PREFIX}/include/julia)

# Get Julia library
get_filename_component(Julia_LIBDIR ${Julia_BINDIR} DIRECTORY)
find_library(Julia_LIBRARY
    NAMES julia libjulia
    PATHS ${Julia_BINDIR} ${Julia_LIBDIR}/lib
    NO_DEFAULT_PATH
)
set(Julia_LIBRARIES ${Julia_LIBRARY})

# Find main header
find_path(Julia_MAIN_HEADER julia.h
    PATHS ${Julia_INCLUDE_DIRS}
    NO_DEFAULT_PATH
)

# Handle the QUIETLY and REQUIRED arguments and set Julia_FOUND
find_package_handle_standard_args(Julia
    REQUIRED_VARS
        Julia_EXECUTABLE
        Julia_MAIN_HEADER
        Julia_LIBRARIES
        Julia_INCLUDE_DIRS
    VERSION_VAR
        Julia_VERSION_STRING
)

mark_as_advanced(
    Julia_EXECUTABLE
    Julia_MAIN_HEADER
    Julia_LIBRARIES
    Julia_INCLUDE_DIRS
)
