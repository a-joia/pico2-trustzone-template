#!/bin/bash
set -e  # Exit immediately on any command failure

CMAKECMD=cmake
GCC=~/.pico-sdk/toolchain/14_2_Rel1/bin/arm-none-eabi-gcc
OBJDUMP=~/.pico-sdk/toolchain/14_2_Rel1/bin/arm-none-eabi-objdump 

# if argument is -clean
if [ "$1" == "--clean" ]; then
    echo "[LOG] Cleaning build directories..."
    rm -rf build_secure
    rm -rf build_nonsecure
fi


# if build_secure dont exist
if [ ! -d "build_secure" ]; then
    mkdir build_secure
fi
if [ ! -d "build_nonsecure" ]; then
    mkdir build_nonsecure
fi

# # --- Secure Build ---
echo "[LOG] Building secure firmware..."
cd build_secure
$CMAKECMD -G Ninja .. -DCMAKE_TOOLCHAIN_FILE=../toolchain/rp2350.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_SECURE=1
$CMAKECMD --build . --verbose #| tee ../secure_build.log
cd ..
echo "[LOG] Secure build completed."

# --- Non-Secure Build ---
echo "[LOG] Building non-secure firmware..."
cd build_nonsecure
$CMAKECMD -G Ninja .. -DCMAKE_TOOLCHAIN_FILE=../toolchain/rp2350.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_NONSECURE=1
$CMAKECMD --build . --verbose #| tee ../nonsecure_build.log
cd ..
echo "[LOG] Nonsecure build completed."

# --- Objdump (only after both builds are done) ---
echo "[LOG] Generating disassembly files..."
$OBJDUMP -D build_secure/secure/secure.elf > build_secure/secure/secure.elf.dis
$OBJDUMP -D build_nonsecure/nonsecure/nonsecure.elf > build_nonsecure/nonsecure/nonsecure.elf.dis
echo "[LOG] Disassembly files generated."

echo "[LOG] Build process completed."