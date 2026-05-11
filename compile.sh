#!/bin/bash
set -e  # Exit immediately on any command failure

CMAKECMD=cmake
# Prefer toolchain binaries inside the pico-sdk, fallback to PATH if available
DEFAULT_GCC="$HOME/.pico-sdk/toolchain/14_2_Rel1/bin/arm-none-eabi-gcc"
if [ -x "$DEFAULT_GCC" ]; then
    GCC="$DEFAULT_GCC"
elif command -v arm-none-eabi-gcc >/dev/null 2>&1; then
    GCC=$(command -v arm-none-eabi-gcc)
else
    GCC=""
fi

# Ensure Pico SDK is available at the path expected by the build (clone if missing)
PICO_SDK_DIR="$HOME/.pico-sdk/sdk/2.1.1"
if [ ! -d "$PICO_SDK_DIR" ]; then
    echo "[WARN] Pico SDK not found at $PICO_SDK_DIR."
    # If running in a non-interactive shell, default to not installing
    if [ ! -t 0 ]; then
        echo "[WARN] Non-interactive shell detected — skipping automatic SDK install."
        echo "[ERROR] Pico SDK missing. Please install it or run this script interactively to allow installation."
        exit 1
    fi
    read -p "Install pico-sdk to $PICO_SDK_DIR now? [y/N]: " reply
    reply=${reply:-N}
    case "$reply" in
        [Yy]|[Yy][Ee][Ss])
            echo "[LOG] Cloning pico-sdk to $PICO_SDK_DIR..."
            mkdir -p "$(dirname "$PICO_SDK_DIR")"
            git clone https://github.com/raspberrypi/pico-sdk.git "$PICO_SDK_DIR"
            echo "[LOG] Initializing pico-sdk submodules..."
            (cd "$PICO_SDK_DIR" && git submodule update --init --recursive)
            echo "[LOG] Pico SDK cloned to $PICO_SDK_DIR"
            ;;
        *)
            echo "[ERROR] Pico SDK not installed — aborting build."
            exit 1
            ;;
    esac
fi

# Locate a usable objdump (prefer bundled toolchain, fallback to PATH)
DEFAULT_OBJDUMP="$HOME/.pico-sdk/toolchain/14_2_Rel1/bin/arm-none-eabi-objdump"
if [ -x "$DEFAULT_OBJDUMP" ]; then
    OBJDUMP="$DEFAULT_OBJDUMP"
elif command -v arm-none-eabi-objdump >/dev/null 2>&1; then
    OBJDUMP=$(command -v arm-none-eabi-objdump)
else
    OBJDUMP=""
fi

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
if [ -z "$OBJDUMP" ]; then
    echo "[WARN] arm-none-eabi-objdump not found; skipping disassembly generation. Install 'gcc-arm-none-eabi' or ensure your toolchain is available."
else
    $OBJDUMP -D build_secure/secure/secure.elf > build_secure/secure/secure.elf.dis
    $OBJDUMP -D build_nonsecure/nonsecure/nonsecure.elf > build_nonsecure/nonsecure/nonsecure.elf.dis
fi
echo "[LOG] Disassembly files generated."

echo "[LOG] Build process completed."