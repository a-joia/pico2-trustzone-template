
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

void StartDefaultLauncher(void *argument);
void StartDefaultTask2(void *argument);
void StartDefaultTask3(void *argument);

/* Definitions for defaultTask */
osThreadId_t defaultTaskHandle;
osThreadId_t defaultTaskHandle2;
osThreadId_t defaultTaskHandle3;

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

const osThreadAttr_t defaultTask3_attributes = {
        .name = "defaultTask3",
        .priority = (osPriority_t) osPriorityNormal,
        .stack_size = 128 * 4
        };
                
void init_systick(uint32_t uwTickFreq){
        // Disable SysTick
        systick_hw->csr = 0; 
        systick_hw->rvr = 100000 - 1; // Set reload value

        // Set the SysTick frequency
        SysTick_Config(SystemCoreClock / (1000U / (uint32_t)uwTickFreq)) ; // Set SysTick to 1ms
        
        // Enable SysTick interrupt
        NVIC_EnableIRQ(SysTick_IRQn); // 
        
        // Set SysTick interrupt priorityx
        NVIC_SetPriority(SysTick_IRQn, 0); //
        
        // enable systick 
        systick_hw->csr = 0x10007;
        
        // enable einterrupts
        __enable_irq(); 
}

int main(void){
        // Init pritf stuff
        stdio_init_all();

        // Initialize FreeRTOS kernel
        osKernelInitialize();
        
        // Create static tasks
        defaultTaskHandle  = osThreadNew(StartDefaultLauncher , NULL, &defaultTask_attributes);
        
        // Initialize the systick
        init_systick(1000); // Set SysTick to `1khz
        
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

void StartDefaultTask3(void *argument){
        /* Infinite loop */
           while(1){
                // Secure_Test_Call();
                // printf("Hello from non-secure world, task 2\n");
        }
}

void StartDefaultLauncher(void *argument){
        defaultTaskHandle2 = osThreadNew(StartDefaultTask2, NULL, &defaultTask2_attributes);
        defaultTaskHandle3 = osThreadNew(StartDefaultTask3, NULL, &defaultTask3_attributes);

        /* End initial task */
        osThreadExit();

        /* Infinite loop */
        while(1){} // should never reach here
}
