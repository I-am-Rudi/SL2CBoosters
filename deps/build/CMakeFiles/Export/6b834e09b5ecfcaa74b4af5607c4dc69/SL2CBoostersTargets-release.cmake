#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SL2CBoosters::sl2cboosters" for configuration "Release"
set_property(TARGET SL2CBoosters::sl2cboosters APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SL2CBoosters::sl2cboosters PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "wigxjpf"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libsl2cboosters.so"
  IMPORTED_SONAME_RELEASE "libsl2cboosters.so"
  )

list(APPEND _cmake_import_check_targets SL2CBoosters::sl2cboosters )
list(APPEND _cmake_import_check_files_for_SL2CBoosters::sl2cboosters "${_IMPORT_PREFIX}/lib/libsl2cboosters.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
