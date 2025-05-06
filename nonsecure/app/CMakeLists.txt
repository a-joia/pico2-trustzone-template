cmake_minimum_required(VERSION 3.20.0)


# set(BOARD rpi_pico2)

find_package(Zephyr)
project(zephyr_app)

target_sources(app PRIVATE src/main.c)

#add compilation flags - define flag
target_compile_definitions(app PRIVATE
    -DPICO_RUNTIME_NO_INIT_PER_CORE_ENABLE_COPROCESSORS=1
)