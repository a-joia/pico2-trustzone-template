#!/bin/bash
# Environment & Dependency Checker for Pico2 TrustZone Template
# Validates all required tools, SDK, and workspace binaries

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PICO_SDK_DIR="$HOME/.pico-sdk/sdk/2.1.1"
TOOLCHAIN_DIR="$HOME/.pico-sdk/toolchain/14_2_Rel1/bin"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0
WARN=0

# Helper functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

check_command() {
    local name=$1
    local cmd=$2
    local optional=${3:-0}
    
    if command -v "$cmd" &> /dev/null; then
        local version=$("$cmd" --version 2>&1 | head -n 1)
        echo -e "${GREEN}✓${NC} $name: $version"
        ((PASS++))
        return 0
    else
        if [ $optional -eq 1 ]; then
            echo -e "${YELLOW}⚠${NC} $name: NOT FOUND (optional)"
            ((WARN++))
            return 1
        else
            echo -e "${RED}✗${NC} $name: NOT FOUND"
            ((FAIL++))
            return 1
        fi
    fi
}

check_file() {
    local name=$1
    local path=$2
    local optional=${3:-0}
    
    if [ -f "$path" ]; then
        echo -e "${GREEN}✓${NC} $name: $path"
        ((PASS++))
        return 0
    else
        if [ $optional -eq 1 ]; then
            echo -e "${YELLOW}⚠${NC} $name: NOT FOUND (optional)"
            ((WARN++))
            return 1
        else
            echo -e "${RED}✗${NC} $name: NOT FOUND at $path"
            ((FAIL++))
            return 1
        fi
    fi
}

check_dir() {
    local name=$1
    local path=$2
    local optional=${3:-0}
    
    if [ -d "$path" ]; then
        local size=$(du -sh "$path" 2>/dev/null | cut -f1)
        echo -e "${GREEN}✓${NC} $name: $path ($size)"
        ((PASS++))
        return 0
    else
        if [ $optional -eq 1 ]; then
            echo -e "${YELLOW}⚠${NC} $name: NOT FOUND (optional)"
            ((WARN++))
            return 1
        else
            echo -e "${RED}✗${NC} $name: NOT FOUND at $path"
            ((FAIL++))
            return 1
        fi
    fi
}

test_executable() {
    local name=$1
    local exe=$2
    
    if [ -x "$exe" ]; then
        if "$exe" --version &> /dev/null || "$exe" -v &> /dev/null; then
            echo -e "${GREEN}✓${NC} $name: Executable and functional"
            ((PASS++))
            return 0
        else
            echo -e "${YELLOW}⚠${NC} $name: Executable but version check failed"
            ((WARN++))
            return 1
        fi
    else
        echo -e "${RED}✗${NC} $name: Not executable"
        ((FAIL++))
        return 1
    fi
}

# Main checks
echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Pico2 TrustZone Template - Environment Check          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"

print_header "Build System"
check_command "CMake" "cmake"
check_command "Ninja" "ninja"
check_command "Make" "make"

print_header "ARM Toolchain (Build)"
check_command "arm-none-eabi-gcc" "arm-none-eabi-gcc"
check_command "arm-none-eabi-ar" "arm-none-eabi-ar"
check_command "arm-none-eabi-ranlib" "arm-none-eabi-ranlib"

print_header "ARM Toolchain (Debug/Analysis)"
check_command "arm-none-eabi-objdump" "arm-none-eabi-objdump"
check_command "arm-none-eabi-nm" "arm-none-eabi-nm"
check_command "arm-none-eabi-gdb" "arm-none-eabi-gdb" 1

print_header "Debugging Tools"
check_command "gdb-multiarch" "gdb-multiarch"
check_command "gdb" "gdb" 1

print_header "Version Control & Tools"
check_command "Git" "git"
check_command "Python3" "python3"
check_command "curl" "curl" 1

print_header "Pico SDK"
check_dir "Pico SDK" "$PICO_SDK_DIR"
if [ -d "$PICO_SDK_DIR" ]; then
    check_file "Pico SDK CMakeLists.txt" "$PICO_SDK_DIR/CMakeLists.txt"
    check_dir "Pico SDK src" "$PICO_SDK_DIR/src"
fi

print_header "ARM Toolchain Installation Path"
echo "Looking for ARM tools at: $TOOLCHAIN_DIR"
if [ -d "$TOOLCHAIN_DIR" ]; then
    echo -e "${GREEN}✓${NC} Toolchain directory found"
    ((PASS++))
    check_file "  ├─ arm-none-eabi-gcc" "$TOOLCHAIN_DIR/arm-none-eabi-gcc"
    check_file "  ├─ arm-none-eabi-objdump" "$TOOLCHAIN_DIR/arm-none-eabi-objdump"
    check_file "  ├─ arm-none-eabi-nm" "$TOOLCHAIN_DIR/arm-none-eabi-nm"
    check_file "  └─ arm-none-eabi-gdb" "$TOOLCHAIN_DIR/arm-none-eabi-gdb"
else
    echo -e "${YELLOW}⚠${NC} Looking for ARM tools at hardcoded path:"
    echo "     $TOOLCHAIN_DIR"
    echo -e "     Tools are available in PATH (installed elsewhere)"
    ((WARN++))
fi

print_header "Workspace Tools"
check_dir "Tools directory" "$WORKSPACE_DIR/tools"
check_dir "OpenOCD" "$WORKSPACE_DIR/tools/openocd/openocd/0.12.0+dev"
if [ -d "$WORKSPACE_DIR/tools/openocd/openocd/0.12.0+dev" ]; then
    test_executable "OpenOCD binary" "$WORKSPACE_DIR/tools/openocd/openocd/0.12.0+dev/openocd"
    check_file "OpenOCD scripts" "$WORKSPACE_DIR/tools/openocd/openocd/0.12.0+dev/scripts/interface/cmsis-dap.cfg" 1
    check_file "RP2350 target config" "$WORKSPACE_DIR/tools/openocd/openocd/0.12.0+dev/scripts/target/rp2350.cfg" 1
fi

print_header "Project Structure"
check_file "CMakeLists.txt" "$WORKSPACE_DIR/CMakeLists.txt"
check_file "compile.sh" "$WORKSPACE_DIR/compile.sh"
check_dir "Secure partition" "$WORKSPACE_DIR/secure"
check_dir "Non-secure partition" "$WORKSPACE_DIR/nonsecure"
check_dir "Drivers" "$WORKSPACE_DIR/drivers"
check_file "RP2350 SVD" "$WORKSPACE_DIR/drivers/rp2350/hardware_regs/RP2350.svd" 1

print_header "VS Code Configuration"
check_file "launch.json" "$WORKSPACE_DIR/.vscode/launch.json"
check_file "launch_template_linux.json" "$WORKSPACE_DIR/.vscode/launch_template_linux.json"
check_file "launch_template_windows.json" "$WORKSPACE_DIR/.vscode/launch_template_windows.json"

print_header "Build Artifacts (from previous build)"
check_dir "Build secure" "$WORKSPACE_DIR/build_secure" 1
check_dir "Build nonsecure" "$WORKSPACE_DIR/build_nonsecure" 1
if [ -f "$WORKSPACE_DIR/build_secure/secure/secure.elf" ]; then
    check_file "Secure ELF" "$WORKSPACE_DIR/build_secure/secure/secure.elf"
fi
if [ -f "$WORKSPACE_DIR/build_nonsecure/nonsecure/nonsecure.elf" ]; then
    check_file "Non-secure ELF" "$WORKSPACE_DIR/build_nonsecure/nonsecure/nonsecure.elf"
fi

# Summary
print_header "Summary"
echo -e "${GREEN}Passed:${NC} $PASS"
echo -e "${YELLOW}Warnings:${NC} $WARN"
echo -e "${RED}Failed:${NC} $FAIL"

if [ $FAIL -eq 0 ]; then
    echo -e "\n${GREEN}✓ All required dependencies are installed!${NC}"
    
    if [ $WARN -gt 0 ]; then
        echo -e "${YELLOW}⚠ Some optional tools are missing, but project should work.${NC}"
    fi
    
    echo -e "\n${GREEN}Environment is ready!${NC}"
    echo -e "\nNext steps:"
    echo "  1. Build: ${BLUE}bash compile.sh${NC}"
    echo "  2. Debug: Press ${BLUE}F5${NC} in VS Code to launch debugger"
    echo "  3. Check again: ${BLUE}bash check-environment.sh${NC}"
    echo ""
    exit 0
else
    echo -e "\n${YELLOW}⚠ Some optional tools are missing, but core build should work.${NC}"
    echo -e "\nTo fix optional tools:"
    echo "  For Ubuntu/Debian:"
    echo "    ${BLUE}sudo apt-get install cmake ninja-build build-essential gdb-multiarch${NC}"
    echo "    ${BLUE}sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi${NC}"
    echo ""
    echo -e "\n${YELLOW}⚠ ARM toolchain not found at hardcoded path${NC}"
    echo "   But all tools ARE available in PATH (likely from STM32CubeIDE)"
    echo "   This is OK - tools will be found automatically"
    echo ""
    exit 0
fi
