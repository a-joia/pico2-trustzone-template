cmake_minimum_required(VERSION 3.20.0)


# set(BOARD rpi_pico2)

find_package(Zephyr)
project(zephyr_app)

target_sources(app PRIVATE src/main.c)