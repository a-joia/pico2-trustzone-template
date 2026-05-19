# Pico2 TrustZone Template

Temporary template for ARM TrustZone-M on Raspberry Pi Pico 2. **NOT for production use.**

# IMPORTANT


By default, Pico 2 configures its features as `Secure`. To allow the `Non Secure World` to use them you will need to explicitally configure it. Check this function as example: [config_peripherals_be_accessible_by_ns](https://github.com/a-joia/pico2-trustzone-template/blob/3a026786b3d82cc25908fb478c09587cf8cd0b81/secure/src/main_s.c#L72)


## Table of Contents

- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Environment Setup](#environment-setup)
- [Build Instructions](#build-instructions)
- [Debugging](#debugging)
- [Troubleshooting](#troubleshooting)

## Quick Start

```bash
# 1. Check environment
bash check-environment.sh

# 2. Build
bash compile.sh

# 3. Debug (in VS Code)
# Press F5 or go to Run → Start Debugging
```

## Project Structure

### Security Domains

```
secure/          - Secure world code (ARM Cortex-M33 with CMSE)
  include/       - Secure headers and NSC (Non-Secure Callable) exports
  src/           - Secure implementation
  secure.ld      - Secure linker script

nonsecure/       - Non-secure world code
  include/       - Non-secure headers
  src/           - Non-secure implementation
  nonsecure.ld   - Non-secure linker script
```

### Build System

```
CMakeLists.txt          - Root CMake configuration
cmake/                  - CMake helper modules
compile.sh              - Build orchestration script
toolchain/rp2350.cmake  - RP2350-specific toolchain

build_secure/           - Secure partition artifacts
build_nonsecure/        - Non-secure partition artifacts
```

### Debugging & Tools

```
tools/openocd/          - Workspace-bundled OpenOCD 0.12.0+dev
.vscode/launch.json     - Cortex-Debug configurations
check-environment.sh    - Environment validation script
try_to_open_device.sh   - Device connection diagnostic
```


## Environment Setup

### Prerequisites

- **Hardware:**
  - Raspberry Pi Pico 2
  - Raspberry Pi Debug Probe (or compatible CMSIS-DAP probe)

- **Software (Linux/Ubuntu):**
  - CMake 3.20+
  - Ninja or Make
  - ARM GCC toolchain (arm-none-eabi-gcc, arm-none-eabi-gdb)
  - gdb-multiarch
  - Pico SDK 2.1.1

### Installation

#### 1. Check Current Setup

```bash
bash check-environment.sh
```

This validates:
- Build tools (CMake, Ninja, Make)
- ARM toolchain (GCC, GDB, objdump, nm)
- Pico SDK location
- Workspace OpenOCD binary
- VS Code launch configurations

#### 2. Install Missing Tools (Ubuntu 24.04)

```bash
# Build essentials
sudo apt-get update
sudo apt-get install cmake ninja-build build-essential

# ARM toolchain
sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi

# Debugging tools
sudo apt-get install gdb-multiarch

# USB libraries
sudo apt-get install libhidapi-hidraw0
```

#### 3. Install Pico SDK

If `check-environment.sh` reports missing SDK, the build script will prompt to auto-install:

```bash
bash compile.sh
# When prompted: Install pico-sdk to ~/.pico-sdk/sdk/2.1.1? [y/N]:
# Enter: y
```

Or manually:
```bash
git clone https://github.com/raspberrypi/pico-sdk.git ~/.pico-sdk/sdk/2.1.1
cd ~/.pico-sdk/sdk/2.1.1
git submodule update --init
```

#### 4. Configure USB Permissions

To allow user-level debugging without `sudo`:

```bash
# Create udev rule for CMSIS-DAP probe
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0666"' | \
  sudo tee /etc/udev/rules.d/60-cmsis-dap.rules

# Reload rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Or add user to dialout group
sudo usermod -a -G dialout $USER
newgrp dialout
```

## Build Instructions

### Automated Build

```bash
bash compile.sh
```

This:
1. Detects and installs SDK if missing (interactive prompt)
2. Checks for required build tools
3. Builds secure partition → `build_secure/secure/secure.elf`
4. Builds non-secure partition → `build_nonsecure/nonsecure/nonsecure.elf`
5. Generates disassembly files (optional, skipped if tools unavailable)

### Manual Build

```bash
# Secure partition
cmake -B build_secure/cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/rp2350.cmake -DSECURE_WORLD=ON
ninja -C build_secure/cmake

# Non-secure partition
cmake -B build_nonsecure/cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/rp2350.cmake -DSECURE_WORLD=OFF
ninja -C build_nonsecure/cmake
```

### Build Artifacts

| File | Location | Purpose |
|------|----------|---------|
| `secure.elf` | `build_secure/secure/` | Secure partition firmware |
| `nonsecure.elf` | `build_nonsecure/nonsecure/` | Non-secure partition firmware |
| `*.dis` | `build_*/` | Disassembly files (debugging reference) |

## Debugging

### Hardware Connection

Connect your CMSIS-DAP probe to the Pico 2:

| Probe Pin | Pico 2 Pin | Signal |
|-----------|-----------|--------|
| SWCLK     | GPIO24    | Clock  |
| SWDIO     | GPIO25    | Data   |
| GND       | GND       | Ground |
| VCC       | 3.3V      | Power (optional) |

### Launch Debugger

**In VS Code:**
1. Press `F5` or go to **Run → Start Debugging**
2. Select launch configuration:
   - **"Pico Debug (Cortex-Debug)"** — Built-in OpenOCD (recommended)
   - **"Pico Debug (Cortex-Debug with external OpenOCD)"** — External OpenOCD process
   - **"Pico Debug (C++ Debugger)"** — cppdbg (alternative)

**Debugger Features:**
- Load secure + non-secure partitions automatically
- Hardware breakpoints (4 supported)
- Single-stepping
- Variable inspection
- SVD register view (RP2350 hardware registers)

### Debug Configuration

Launch configurations are in `.vscode/launch.json`:
- Uses workspace-bundled OpenOCD (`tools/openocd/openocd/0.12.0+dev/openocd`)
- Automatically detects ARM toolchain
- All paths are portable (`${workspaceFolder}`, `${env:HOME}`)

For Windows, use `launch_template_windows.json` as a template.

## Troubleshooting

### Quick Diagnostics

```bash
bash try_to_open_device.sh
```

This script:
1. ✅ Checks if CMSIS-DAP probe is detected
2. ✅ Attempts OpenOCD connection
3. ✅ Reports specific failure causes with solutions

### Common Issues

#### "Probe not found"
- Verify USB cable connected to probe and computer
- Check probe has power/LED indicator lit
- Try different USB port
- On Windows/Mac, install CMSIS-DAP drivers

#### "Cannot read target IDR" / "No response from target"
- Check SWD wire connections (SWCLK, SWDIO, GND)
- Verify Pico 2 board is powered
- Power cycle the target board
- Inspect for loose connectors or solder joints

#### "Permission denied" / "Cannot open USB device"
- Run: `sudo usermod -a -G dialout $USER`
- Then: `newgrp dialout`
- Or create udev rule (see [USB Permissions](#4-configure-usb-permissions))

#### "arm-none-eabi-gcc: command not found"
- Run: `bash check-environment.sh` to verify installation
- Install: `sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi`

#### Build fails with CMake errors
- Delete build directories: `rm -rf build_*`
- Verify Pico SDK location: `ls ~/.pico-sdk/sdk/2.1.1/CMakeLists.txt`
- Check SDK submodules: `cd ~/.pico-sdk/sdk/2.1.1 && git submodule update --init`

### Debug Output

Check these terminals in VS Code:
- **Debug Console** — GDB output and variable inspection
- **Terminal (gdb-server)** — OpenOCD output and probe communication

## References

- [ARM TrustZone-M Overview](https://developer.arm.com/documentation/100690/latest/)
- [RP2350 Datasheet](https://datasheets.raspberrypi.org/rp2350/rp2350-datasheet.pdf)
- [OpenOCD Documentation](https://openocd.org/doc/)
- [Cortex-Debug Extension](https://github.com/marus25/cortex-debug)
