cmake_minimum_required(VERSION 3.13)
project(MyTrustZoneProject C CXX)


include("cmake/macros.cmake")
include("cmake/on_device.cmake")

set(PICO_PLATFORM_CMAKE_FILE "${CMAKE_SOURCE_DIR}/cmake/rp2350-arm-s.cmake" CACHE STRING "")
set(RP2_VARIANT_DIR "rp2350" CACHE STRING "")
include("cmake/source.cmake")

# include("pico-sdk/macros.cmake")


# Use a toolchain if needed (optional)
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain/rp2350.cmake" CACHE STRING "")

set(PICO_RISCV "0" CACHE INTERNAL "")
set(PICO_C_COMPILER_IS_GNU "1" CACHE INTERNAL "")


# set PICO_SDK_PATH to the path of the pico-sdk
set(PICO_SDK_PATH "~/.pico-sdk/sdk/2.1.1" CACHE STRING "")

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_SOURCE_DIR}/tools")

# set board
set(PICO_BOARD "pico2" CACHE STRING "Board type")
# set(PICO_BOARD pico2 CACHE STRING "")

# set compilation typex
set(PICO_CMAKE_BUILD_TYPE "Debug" CACHE STRING "")
 
# set copy to ram
set(PICO_COPY_TO_RAM "0" CACHE STRING "")

set(PICO_CLIB "newlib" CACHE STRING "")

# In your toolchain file:
# set pico sdk version
set(PICO_SDK_VERSION "2.1.1" CACHE STRING "")

#define env var for picotool
set(PICOTOOL_FETCH_FROM_GIT_PATH "${CMAKE_SOURCE_DIR}/picotool" CACHE STRING "")

set(PICO_PLATFORM_CMAKE_FILE "${CMAKE_SOURCE_DIR}/toolchain/rp2350.cmake" )

# add generate_config_header.cmake to the list of files to be processed

set(ROOT_PATH_PR_COMMON "${CMAKE_SOURCE_DIR}/drivers" CACHE STRING "")

add_subdirectory(${CMAKE_SOURCE_DIR}/tools)
# include("cmake/rp2_common.cmake")

# PICO_CMAKE_CONFIG: PICO_NO_FLASH, Option to default all binaries to not use flash i.e. run from SRAM, type=bool, default=0, group=build, docref=cmake-binary-type-config
option(PICO_NO_FLASH "Default binaries to not not use flash")
# PICO_CMAKE_CONFIG: PICO_COPY_TO_RAM, Option to default all binaries to copy code from flash to SRAM before running, type=bool, default=0, group=build, docref=cmake-binary-type-config
option(PICO_COPY_TO_RAM "Default binaries to copy code to RAM when booting from flash")


add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_fix)

if (BUILD_SECURE) 
    add_subdirectory(secure)
endif()

if (BUILD_NONSECURE) 
    add_subdirectory(nonsecure)
endif()

# add_subdirectory(secure)
# add_subdirectory(nonsecure)

pico_add_doxygen_exclude(${RP2_VARIANT_DIR}/hardware_regs) # very very big
# but we DO want dreq.h; it doesn't change much, so lets just use configure_file
configure_file(drivers/${RP2_VARIANT_DIR}/hardware_regs/include/hardware/regs/dreq.h ${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen/dreq.h COPYONLY)
# also intctrl.h
configure_file(drivers/${RP2_VARIANT_DIR}/hardware_regs/include/hardware/regs/intctrl.h ${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen/intctrl.h COPYONLY)
pico_add_doxygen(${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen)

#pico_add_doxygen(rp2_common)
pico_add_doxygen_exclude(rp2_common/cmsis) # very big
