# This file is part of Noggit3, licensed under GNU General Public License (version 3).

#find STORMLIB
# STORMLIB_LIBRARIES, the name of the library to link against
# STORMLIB_FOUND, if false, do not try to link
# STORMLIB_INCLUDES,

find_path(STORMLIB_INCLUDE_DIR StormLib.h StormPort.h PATH_SUFFIXES src)
find_path(STORMLIB_LIBRARY_DIR StormLib.lib PATH_SUFFIXES lib)
find_library(STORMLIB_LIBRARY NAMES StormLib storm PATH_SUFFIXES lib)
set(STORMLIB_LIBRARIES ${STORMLIB_LIBRARY})
if( WIN32 )
  find_library(STORMLIB_LIBRARYRAD StormLibRAD.lib PATH_SUFFIXES lib PATHS ${STORMLIB_LIBRARY_DIR})
  find_library(STORMLIB_LIBRARYDAD StormLibDAD.lib PATH_SUFFIXES lib PATHS ${STORMLIB_LIBRARY_DIR})
  set(STORMLIB_LIBRARIES ${STORMLIB_LIBRARIES} ${STORMLIB_LIBRARYRAD} ${STORMLIB_LIBRARYDAD})
endif( WIN32 )

if(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY)
    SET(STORMLIB_FOUND TRUE)
endif(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY)

set(STORMLIB_INCLUDES ${STORMLIB_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(StormLib DEFAULT_MSG STORMLIB_LIBRARY STORMLIB_INCLUDE_DIR)

mark_as_advanced(STORMLIB_INCLUDE_DIR STORMLIB_LIBRARYRAD STORMLIB_LIBRARYDAD)

add_library (StormLib INTERFACE)
target_link_libraries (StormLib INTERFACE ${STORMLIB_LIBRARIES})
set_property  (TARGET StormLib APPEND PROPERTY INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${STORMLIB_INCLUDE_DIR})
set_property  (TARGET StormLib APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${STORMLIB_INCLUDE_DIR})

#! \note on Windows, storm tries to auto-link. There is no proper flag to disable that, so abuse this one.
target_compile_definitions (StormLib INTERFACE -D__STORMLIB_SELF__)
