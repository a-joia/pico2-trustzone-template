# if (NOT TARGET armm33_freertos)
#         pico_add_library(armm33_freertos)


#         if (BUILD_NONSECURE) 
        
#                 target_include_directories(armm33_freertos SYSTEM INTERFACE
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/include
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/CMSIS_RTOS_V2
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/MemMang)
                
#                 target_sources(armm33_freertos INTERFACE
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/tasks.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/timers.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/queue.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/list.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/stream_buffer.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/event_groups.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/croutine.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/non_secure/port.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/non_secure/portmacro.h
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/non_secure/portasm.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/MemMang/heap_4.c          
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/CMSIS_RTOS_V2/cmsis_os2.c  
#                 )
#         endif()


#         if (BUILD_SECURE) 
#                 target_sources(armm33_freertos INTERFACE
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure/secure_context_port.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure/secure_context.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure/secure_heap.c
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure/secure_init.c
#                 )

#                 target_include_directories(armm33_freertos SYSTEM INTERFACE
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/include
#                 ${CMAKE_CURRENT_LIST_DIR}/Source/portable/GCC/ARM_CM33/secure
#                 )
#         endif()
# #include headers
# endif()

