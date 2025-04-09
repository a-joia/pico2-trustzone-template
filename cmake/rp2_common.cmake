# Used for RP2040 and RP2350

# PICO_CMAKE_CONFIG: PICO_NO_FLASH, Option to default all binaries to not use flash i.e. run from SRAM, type=bool, default=0, group=build, docref=cmake-binary-type-config
option(PICO_NO_FLASH "Default binaries to not not use flash")
# PICO_CMAKE_CONFIG: PICO_COPY_TO_RAM, Option to default all binaries to copy code from flash to SRAM before running, type=bool, default=0, group=build, docref=cmake-binary-type-config
option(PICO_COPY_TO_RAM "Default binaries to copy code to RAM when booting from flash")

# RP2040/RP2350 specific From standard build variants
add_subdirectory(${ROOT_PATH_PR_COMMON}/${RP2_VARIANT_DIR}/pico_platform)
add_subdirectory(${ROOT_PATH_PR_COMMON}/${RP2_VARIANT_DIR}/hardware_regs)
add_subdirectory(${ROOT_PATH_PR_COMMON}/${RP2_VARIANT_DIR}/hardware_structs)
add_subdirectory(${ROOT_PATH_PR_COMMON}/${RP2_VARIANT_DIR}/boot_stage2)
# COMMON
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/boot_picobin_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/boot_picoboot_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/boot_uf2_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_base_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_usb_reset_interface_headers)

# PICO_CMAKE_CONFIG: PICO_BARE_METAL, Flag to exclude anything except base headers from the build, type=bool, default=0, group=build
if (NOT PICO_BARE_METAL)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_bit_ops_headers)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_binary_info)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_divider_headers)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_sync)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_time)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_util)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_stdlib_headers)
endif()
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/hardware_claim)
#

add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_base)
# HAL items which expose a public (inline rp2_common) functions/macro API above the raw hardware
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_adc)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_boot_lock)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_clocks)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_divider)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_dma)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_exception)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_flash)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_gpio)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_i2c)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_interp)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_irq)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_pio)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_pll)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_pwm)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_resets)
if (PICO_RP2040 OR PICO_COMBINED_DOCS)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_rtc)
endif()
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_spi)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_sync)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_sync_spin_lock)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_ticks)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_timer)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_uart)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_vreg)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_watchdog)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_xip_cache)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_xosc)

if (PICO_RP2350 OR PICO_COMBINED_DOCS)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_powman)
    # Note in spite of the name this is usable on Arm as well as RISC-V:
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_riscv_platform_timer)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_sha256)
endif()

if (PICO_RP2350 OR PICO_COMBINED_DOCS)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_dcp)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_rcp)
endif()

if (PICO_RISCV OR PICO_COMBINED_DOCS)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_riscv)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/hardware_hazard3)
endif()

# Basic bootrom headers
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/boot_bootrom_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_platform_compiler)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_platform_sections)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_platform_panic)

if (NOT PICO_BARE_METAL)
    # NOTE THE ORDERING HERE IS IMPORTANT AS SOME TARGETS CHECK ON EXISTENCE OF OTHER TARGETS
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_aon_timer)
    # Helper functions to connect to data/functions in the bootrom
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_bootrom)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_bootsel_via_double_reset)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_multicore)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_unique_id)

    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_atomic)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_bit_ops)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_divider)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_double)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_int64_ops)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_flash)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_float)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_mem_ops)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_malloc)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_printf)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_rand)

    if (PICO_RP2350 OR PICO_COMBINED_DOCS)
        add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_sha256)
    endif()

    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio_semihosting)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio_uart)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio_rtt)

    if (NOT PICO_RISCV)
         add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/cmsis)
    endif()
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/tinyusb)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio_usb)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_i2c_slave)

    # networking libraries - note dependency order is important
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_async_context)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_btstack)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_cyw43_driver)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_lwip)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_cyw43_arch)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_mbedtls)

    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_time_adapter)

    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_crt0)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_clib_interface)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_cxx_options)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_standard_binary_info)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_standard_link)

    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_fix)

    # at the end as it includes a lot of other stuff
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_runtime_init)
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_runtime)

    # this requires all the pico_stdio_ libraries
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio)
    # this requires runtime
    add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdlib)
endif()

# configure doxygen directories
#pico_add_doxygen(${COMMON_DIR})
#pico_add_doxygen(${RP2_VARIANT_DIR})
pico_add_doxygen_exclude(${RP2_VARIANT_DIR}/hardware_regs) # very very big
# but we DO want dreq.h; it doesn't change much, so lets just use configure_file
configure_file(drivers/${RP2_VARIANT_DIR}/hardware_regs/include/hardware/regs/dreq.h ${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen/dreq.h COPYONLY)
# also intctrl.h
configure_file(drivers/${RP2_VARIANT_DIR}/hardware_regs/include/hardware/regs/intctrl.h ${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen/intctrl.h COPYONLY)
pico_add_doxygen(${CMAKE_CURRENT_BINARY_DIR}/extra_doxygen)

#pico_add_doxygen(rp2_common)
pico_add_doxygen_exclude(rp2_common/cmsis) # very big
