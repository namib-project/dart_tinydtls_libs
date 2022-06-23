cmake_minimum_required(VERSION 3.10)

include(../third_party/tinydtls/AutoConf.cmake)
set(PLATFORM "posix")
set(DTLS_ECC ON)
set(DTLS_PSK ON)

configure_file(../third_party/tinydtls/dtls_config.h.cmake.in ${CMAKE_CURRENT_SOURCE_DIR}/../third_party/tinydtls/dtls_config.h)

add_library(tinydtls SHARED)

target_include_directories(tinydtls PUBLIC ../third_party/tinydtls)
target_compile_definitions(tinydtls PUBLIC DTLSv12 WITH_SHA256 SHA2_USE_INTTYPES_H DTLS_CHECK_CONTENTTYPE)

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
