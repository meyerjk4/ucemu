cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    ucemu
    VERSION 0.1.0
    DESCRIPTION "Microcontroller Emulation"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    ucemu_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    ucemu_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(ucemu_lib PUBLIC cxx_std_20)

find_package(fmt REQUIRED)
target_link_libraries(ucemu_lib PRIVATE fmt::fmt)

# ---- Declare executable ----

add_executable(ucemu_exe source/main.cpp)
add_executable(ucemu::exe ALIAS ucemu_exe)

set_property(TARGET ucemu_exe PROPERTY OUTPUT_NAME ucemu)

target_compile_features(ucemu_exe PRIVATE cxx_std_20)

target_link_libraries(ucemu_exe PRIVATE ucemu_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT ucemu_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of ucemu"
  )
endif()

include(cmake/dev-mode.cmake)
