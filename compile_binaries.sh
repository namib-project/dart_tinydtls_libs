#!/bin/bash
# Bash script for compiling tinyDTLS binaries for Linux, Windows, and Android.
#
# Requires android-ndk for compiling the Android binaries and MinGW for the
# Windows binaries.

set -euo pipefail

# Path variables
TINYDTLS_DIRECTORY=$PWD/third_party/tinydtls
BINARIES_DIRECTORY=$PWD/native/lib

# Download tinydtls submodule
git submodule update --init --recursive

# Initialize tinydtls compilation
cd "$TINYDTLS_DIRECTORY"
./autogen.sh

# Compile Linux binary
make -k clean
./configure --host=x86_64-pc-linux-gnu
make
mv libtinydtls.so "$BINARIES_DIRECTORY"/linux_x64/libtinydtls.so

# Compile Windows binary (using MinGW)
make clean
CC=x86_64-w64-mingw32-gcc-posix ./configure --host=x86_64-w64-mingw32
make
mv libtinydtls.so "$BINARIES_DIRECTORY"/windows_x64/libtinydtls.dll

# Compile Android binaries
ANDROID_DIRECTORY=$PWD/android/src/main/jniLibs
NDK=$HOME/Android/Sdk/ndk/24.0.8215888 # Insert your NDK directory here
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

export API=21
# Configure and build.
export AR=$TOOLCHAIN/bin/llvm-ar
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

# Android architectures and target triples that are used as compile targets
# See https://developer.android.com/ndk/guides/other_build_systems#autoconf
declare -a ANDROID_ARCHITECTURES=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")
declare -a ANDROID_TRIPLES=("aarch64-linux-android" "armv7a-linux-androideabi" "i686-linux-android" "x86_64-linux-android")

# Compile Android binaries
for (( i=0; i<${#ANDROID_ARCHITECTURES[*]}; ++i));
do
   make clean
   export TARGET="${ANDROID_TRIPLES[$i]}"
   export CC=$TOOLCHAIN/bin/$TARGET$API-clang
   export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
   export AS=$CC
   CC=$CC ./configure --host "$TARGET"
   make
   mv libtinydtls.so "${ANDROID_DIRECTORY}/${ANDROID_ARCHITECTURES[$i]}"/libtinydtls.so
done
