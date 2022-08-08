cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "dart_tinydtls_libs")
project(${PROJECT_NAME} LANGUAGES C CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "dart_tinydtls_libs_plugin")

add_library(${PLUGIN_NAME} SHARED
  "dart_tinydtls_libs_plugin.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

include(${CMAKE_CURRENT_LIST_DIR}/../common/CMakeLists.txt)
set(PLATFORM "posix")

set(dart_tinydtls_libs_bundled_libraries
  "plugins/${PROJECT_NAME}/libtinydtls.so"
  PARENT_SCOPE
)
