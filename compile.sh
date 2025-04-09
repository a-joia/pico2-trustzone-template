#!/bin/bash
set -e  # Exit immediately on any command failure

rm -rf build_secure
rm -rf build_nonsecure
mkdir build_secure
mkdir build_nonsecure

# # --- Secure Build ---
cd build_secure
cmake -G Ninja .. -DCMAKE_TOOLCHAIN_FILE=../toolchain/rp2350.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_SECURE=1
cmake --build . --verbose #| tee ../secure_build.log
# if return code is 0, then run the next command else exit

cd ..

# --- Non-Secure Build ---
cd build_nonsecure
cmake -G Ninja .. -DCMAKE_TOOLCHAIN_FILE=../toolchain/rp2350.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_NONSECURE=1
cmake --build . --verbose #| tee ../nonsecure_build.log
cd ..



# --- Objdump (only after both builds are done) ---
echo "Generating disassembly files..."
arm-none-eabi-objdump -D build_secure/secure/secure.elf > build_secure/secure/secure.elf.dis
arm-none-eabi-objdump -D build_nonsecure/nonsecure/nonsecure.elf > build_nonsecure/nonsecure/nonsecure.elf.dis
