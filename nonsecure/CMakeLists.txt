project(NonSecureProject C)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/boot_uf2_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/boot_uf2_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_usb_reset_interface_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_usb_reset_interface_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_crt0 ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_crt0)
add_subdirectory(${CMAKE_SOURCE_DIR}/pico-sdk ${CMAKE_BINARY_DIR}/nonsecure/pico-sdk)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_double ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_double)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_divider ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_divider)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/cmsis ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/cmsis)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2350/hardware_regs ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2350/hardware_regs)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2350/hardware_structs ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2350/hardware_structs)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2350/pico_platform ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2350/pico_platform)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_clocks ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_clocks)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_pll ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_pll)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_irq ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_irq)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_sync ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_sync)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_sync_spin_lock ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_sync_spin_lock)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_gpio ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_gpio)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_resets ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_resets)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_vreg ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_vreg)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_watchdog ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_watchdog)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_xosc ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_xosc)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_timer ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_timer)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_runtime_init ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_runtime_init)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_runtime ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_runtime)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/pico_sync ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_sync)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/pico_time ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_time)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/hardware_claim ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/hardware_claim)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_time_adapter ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_time_adapter)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_ticks ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_ticks)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_uart ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_uart)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_bootrom ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_bootrom)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/boot_bootrom_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/boot_bootrom_headers)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_boot_lock ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_boot_lock)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_flash ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_flash)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/boot_picoboot_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/boot_picoboot_headers)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_multicore ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_multicore)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/boot_picobin_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/boot_picobin_headers)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_rcp ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_rcp)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_dcp ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_dcp)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_platform_sections ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_platform_sections)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/pico_util ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_util)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/pico_binary_info ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_binary_info)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_platform_compiler ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_platform_compiler)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_platform_panic ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_platform_panic)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2350/boot_stage2 ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2350/boot_stage2)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_malloc ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_malloc)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_sha256 ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_sha256)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/pico_clib_interface ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_clib_interface)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_aon_timer ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_aon_timer)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_bootsel_via_double_reset ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_bootsel_via_double_reset)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_unique_id ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_unique_id)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_atomic ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_atomic)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_bit_ops ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_bit_ops)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_divider ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_divider)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_int64_ops ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_int64_ops)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_float ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_float)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_mem_ops ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_mem_ops)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_rand ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_rand)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio_uart ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_stdio_uart)  # USING UART FOR PRINTF
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdio ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_stdio)

add_subdirectory(${ROOT_PATH_PR_COMMON}/common/pico_stdlib_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_stdlib_headers)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_stdlib ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_stdlib)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/rp2_common/hardware_base ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/hardware_base)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_cxx_options ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_cxx_options)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_standard_binary_info ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_standard_binary_info)
add_subdirectory(${ROOT_PATH_PR_COMMON}/rp2_common/pico_standard_link ${CMAKE_BINARY_DIR}/nonsecure/drivers/rp2_common/pico_standard_link)
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers/common/pico_base_headers ${CMAKE_BINARY_DIR}/nonsecure/drivers/common/pico_base_headers)

# Gather all C files in the src folder
file(GLOB SECURE_SOURCES "src/*.c")

# Define the executable
add_executable(nonsecure 
    ${SECURE_SOURCES}
    ${CMAKE_SOURCE_DIR}/build_secure/secure/secure_nsclib.o )

# Include folder
target_include_directories(nonsecure PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(nonsecure PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../pico-sdk/include)
target_include_directories(nonsecure PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../drivers/rp2_common/hardware_sync/include)
target_include_directories(nonsecure PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../drivers/rp2_common/hardware_sync_spin_lock/include)


#include lbrary cmsis_core
target_link_libraries(nonsecure PRIVATE 
    cmsis_core 
    pico_stdlib
    )


# Compiler options
target_compile_options(nonsecure PRIVATE
    -mcpu=cortex-m33 
    -std=gnu11 
    -DDEBUG 
    -O0 
    -ffunction-sections 
    -fdata-sections 
    -Wall 
    --specs=nano.specs 
    -mfpu=fpv5-sp-d16 
    -mfloat-abi=hard 
    -mthumb
    -g3 -O0 -DDEBUG
    -Wl,--gc-sections
    -D__ARM8M_MAINLINE__=1
)


# Linker script
target_link_options(nonsecure PRIVATE
    # add ${CMAKE_SOURCE_DIR}/build_secure/secure/secure_nsclib.o

    -T${CMAKE_CURRENT_SOURCE_DIR}/nonsecure.ld
    -mcpu=cortex-m33 
    -std=gnu11 
    -DDEBUG 
    -O0 
    -ffunction-sections 
    -fdata-sections 
    -Wall 
    # --specs=nano.specs 
    -mfpu=fpv5-sp-d16 
    -mfloat-abi=hard 
    -mthumb
    -mcmse
    -Wl,--gc-sections
    --specs=nosys.specs
    -Wl,--wrap=__ctzdi2
    -Wl,--wrap=__aeabi_dadd
    -Wl,--wrap=__aeabi_ddiv
    -Wl,--wrap=__aeabi_dmul
    -Wl,--wrap=__aeabi_drsub
    -Wl,--wrap=__aeabi_dsub
    -Wl,--wrap=__aeabi_cdcmpeq
    -Wl,--wrap=__aeabi_cdrcmple
    -Wl,--wrap=__aeabi_cdcmple
    -Wl,--wrap=__aeabi_dcmpeq
    -Wl,--wrap=__aeabi_dcmplt
    -Wl,--wrap=__aeabi_dcmple
    -Wl,--wrap=__aeabi_dcmpge
    -Wl,--wrap=__aeabi_dcmpgt
    -Wl,--wrap=__aeabi_dcmpun
    -Wl,--wrap=__aeabi_i2d
    -Wl,--wrap=__aeabi_l2d
    -Wl,--wrap=__aeabi_ui2d
    -Wl,--wrap=__aeabi_ul2d
    -Wl,--wrap=__aeabi_d2iz
    -Wl,--wrap=__aeabi_d2lz
    -Wl,--wrap=__aeabi_d2uiz
    -Wl,--wrap=__aeabi_d2ulz
    -Wl,--wrap=__aeabi_d2f
    -Wl,--wrap=sqrt
    -Wl,--wrap=cos
    -Wl,--wrap=sin
    -Wl,--wrap=tan
    -Wl,--wrap=atan2
    -Wl,--wrap=exp
    -Wl,--wrap=log
    -Wl,--wrap=ldexp
    -Wl,--wrap=copysign
    -Wl,--wrap=trunc
    -Wl,--wrap=floor
    -Wl,--wrap=ceil
    -Wl,--wrap=round
    -Wl,--wrap=sincos
    -Wl,--wrap=asin
    -Wl,--wrap=acos
    -Wl,--wrap=atan
    -Wl,--wrap=sinh
    -Wl,--wrap=cosh
    -Wl,--wrap=tanh
    -Wl,--wrap=asinh
    -Wl,--wrap=acosh
    -Wl,--wrap=atanh
    -Wl,--wrap=exp2
    -Wl,--wrap=log2
    -Wl,--wrap=exp10
    -Wl,--wrap=log10
    -Wl,--wrap=pow
    -Wl,--wrap=powint
    -Wl,--wrap=hypot
    -Wl,--wrap=cbrt
    -Wl,--wrap=fmod
    -Wl,--wrap=drem
    -Wl,--wrap=remainder
    -Wl,--wrap=remquo
    -Wl,--wrap=expm1
    -Wl,--wrap=log1p
    -Wl,--wrap=fma
    -Wl,--wrap=__aeabi_l2f
    -Wl,--wrap=__aeabi_ul2f
    -Wl,--wrap=__aeabi_f2lz
    -Wl,--wrap=__aeabi_f2ulz
    -Wl,--wrap=cosf
    -Wl,--wrap=sinf
    -Wl,--wrap=tanf
    -Wl,--wrap=atan2f
    -Wl,--wrap=expf
    -Wl,--wrap=logf
    -Wl,--wrap=sincosf
    -Wl,--wrap=ldexpf
    -Wl,--wrap=copysignf
    -Wl,--wrap=truncf
    -Wl,--wrap=floorf
    -Wl,--wrap=ceilf
    -Wl,--wrap=roundf
    -Wl,--wrap=asinf
    -Wl,--wrap=acosf
    -Wl,--wrap=atanf
    -Wl,--wrap=sinhf
    -Wl,--wrap=coshf
    -Wl,--wrap=tanhf
    -Wl,--wrap=asinhf
    -Wl,--wrap=acoshf
    -Wl,--wrap=atanhf
    -Wl,--wrap=exp2f
    -Wl,--wrap=log2f
    -Wl,--wrap=exp10f
    -Wl,--wrap=log10f
    -Wl,--wrap=powf
    -Wl,--wrap=powintf
    -Wl,--wrap=hypotf
    -Wl,--wrap=cbrtf
    -Wl,--wrap=fmodf
    -Wl,--wrap=dremf
    -Wl,--wrap=remainderf
    -Wl,--wrap=remquof
    -Wl,--wrap=expm1f
    -Wl,--wrap=log1pf
    -Wl,--wrap=fmaf
    -Wl,--wrap=malloc
    -Wl,--wrap=calloc
    -Wl,--wrap=realloc
    -Wl,--wrap=free
    -Wl,-z,max-page-size=4096
    -Wl,--gc-sections
    -Wl,--no-warn-rwx-segments
    -Wl,--wrap=sprintf
    -Wl,--wrap=snprintf
    -Wl,--wrap=vsnprintf
    -Wl,--wrap=printf
    -Wl,--wrap=vprintf
    -Wl,--wrap=puts
    -Wl,--wrap=putchar
    -Wl,--wrap=getchar
    )


    


target_include_directories(nonsecure PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
