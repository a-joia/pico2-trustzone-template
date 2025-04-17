
#include <stdio.h>
#include "pico/stdlib.h"
#include "nsc.h"
#include "hardware/structs/systick.h"
#include "hardware/structs/ticks.h"
#include "hardware/clocks.h"
#include "hardware/ticks.h"
#include "secure_context.h"

#include "_rp2350.h"

#include "cmsis_os2.h"
#include "cmsis_os.h"

#include "secure_init.h"

void StartDefaultTask(void *argument);
void StartDefaultTask2(void *argument);

/* Definitions for defaultTask */
osThreadId_t defaultTaskHandle;
osThreadId_t defaultTaskHandle2;


const osThreadAttr_t defaultTask_attributes = {
        .name = "defaultTask",
        .priority = (osPriority_t) osPriorityNormal,
        .stack_size = 128 * 4
        };

const osThreadAttr_t defaultTask2_attributes = {
        .name = "defaultTask2",
        .priority = (osPriority_t) osPriorityNormal,
        .stack_size = 128 * 4
        };
        

void init_systick(uint32_t uwTickFreq){
        // Disable SysTick
        systick_hw->csr = 0; 
        // Set the SysTick frequency
        SysTick_Config(SystemCoreClock / (1000U / (uint32_t)uwTickFreq)) ; // Set SysTick to 1ms
        // Enable SysTick interrupt
        NVIC_EnableIRQ(SysTick_IRQn); // 
        // Set SysTick interrupt priorityx
        NVIC_SetPriority(SysTick_IRQn, 0); //
        // enable systick 
        systick_hw->csr = 0x10007;
}


int main(void){
        // Init pritf stuff
        stdio_init_all();

        // Initialize the systick
        init_systick(1000); // Set SysTick to `1khz

        // Initialize FreeRTOS kernel
        osKernelInitialize();

        defaultTaskHandle  = osThreadNew(StartDefaultTask , NULL, &defaultTask_attributes);
        defaultTaskHandle2 = osThreadNew(StartDefaultTask2, NULL, &defaultTask2_attributes);

        // Start the FreeRTOS kernel
        osKernelStart();

        while (1){}
        
}


void StartDefaultTask2(void *argument){
        /* Infinite loop */
        while(1){
                // Secure_Test_Call();
                // printf("Hello from non-secure world, task 2\n");
        }
}

void StartDefaultTask(void *argument){
        /* Infinite loop */
        while(1){
                // Secure_Test_Call();
                // printf("Hello from non-secure world, task 1\n");
        }
}
