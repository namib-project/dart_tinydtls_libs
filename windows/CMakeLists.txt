cmake_minimum_required(VERSION 3.14)
set(PROJECT_NAME "dart_tinydtls_libs")
project(${PROJECT_NAME} LANGUAGES C CXX)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "dart_tinydtls_libs_plugin")

add_library(${PLUGIN_NAME} SHARED
  "dart_tinydtls_libs_plugin.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)

include(../third_party/tinydtls/AutoConf.cmake)
set(PLATFORM "windows")
set(DTLS_ECC ON)
set(DTLS_PSK ON)

configure_file(../third_party/tinydtls/dtls_config.h.cmake.in ${CMAKE_CURRENT_SOURCE_DIR}/../third_party/tinydtls/dtls_config.h)

add_library(tinydtls SHARED)

target_include_directories(tinydtls PUBLIC ../third_party/tinydtls)
target_compile_definitions(tinydtls PUBLIC DTLSv12 WITH_SHA256 SHA2_USE_INTTYPES_H DTLS_CHECK_CONTENTTYPE -DDTLS_PSK_MAX_CLIENT_IDENTITY_LEN=256)

target_sources(tinydtls PRIVATE
    ../third_party/tinydtls/dtls.c
    ../third_party/tinydtls/netq.c
    ../third_party/tinydtls/peer.c
    ../third_party/tinydtls/session.c
    ../third_party/tinydtls/crypto.c
    ../third_party/tinydtls/ccm.c
    ../third_party/tinydtls/hmac.c
    ../third_party/tinydtls/dtls_time.c
    ../third_party/tinydtls/dtls_debug.c
    ../third_party/tinydtls/dtls_prng.c
    ../third_party/tinydtls/aes/rijndael.c
    ../third_party/tinydtls/aes/rijndael_wrap.c
    ../third_party/tinydtls/sha2/sha2.c
    ../third_party/tinydtls/ecc/ecc.c)

set(dart_tinydtls_libs_bundled_libraries
  "plugins/${PROJECT_NAME}/$<CONFIG>/tinydtls.dll"
  PARENT_SCOPE
)
