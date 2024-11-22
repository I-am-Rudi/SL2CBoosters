#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "wigxjpf" for configuration "Release"
set_property(TARGET wigxjpf APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wigxjpf PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwigxjpf.so"
  IMPORTED_SONAME_RELEASE "libwigxjpf.so"
  )

list(APPEND _cmake_import_check_targets wigxjpf )
list(APPEND _cmake_import_check_files_for_wigxjpf "${_IMPORT_PREFIX}/lib/libwigxjpf.so" )

# Import target "wigxjpf_quadmath" for configuration "Release"
set_property(TARGET wigxjpf_quadmath APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wigxjpf_quadmath PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libwigxjpf_quadmath.so"
  IMPORTED_SONAME_RELEASE "libwigxjpf_quadmath.so"
  )

list(APPEND _cmake_import_check_targets wigxjpf_quadmath )
list(APPEND _cmake_import_check_files_for_wigxjpf_quadmath "${_IMPORT_PREFIX}/lib/libwigxjpf_quadmath.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
