
#include <stdio.h>
#include "pico/stdlib.h"
#include "nsc.h"
#include "hardware/structs/systick.h"
#include "hardware/structs/ticks.h"
#include "hardware/clocks.h"
#include "hardware/ticks.h"

#include "_rp2350.h"

// #define SYSCLOCK_FREQ 120000 // 120MHz



// int64_t alarm_callback(alarm_id_t id,  void *user_data){
//         printf("Alarm callback triggered\n");
//         // Do something here
//         return 0;
// }

// void sleep(uint32_t ms) {
//         add_alarm_in_ms(ms, alarm_callback, NULL, false);
//         __WFE();
// }





// void init_systick(uint32_t freq){

//         // set_sys_clock_khz(SYSCLOCK_FREQ, true); // Set system clock to 120MHz


//         // systick_ns_hw->csr = 0; // Disable SysTick
//         // systick_ns_hw->rvr = period; // Set reload value
//         // systick_ns_hw->csr = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick with interrupt



// }

// int main(){
//         stdio_init_all();
//         init_systick(1); // Set SysTick to `1khz


//         while(1){
//                 Secure_Test_Call();
           
//                 // sleep_ms(10);
           
//                 printf("Hello from non-secure world\n");
//         }
// }

#include "cmsis_os2.h"
#include "cmsis_os.h"

void StartDefaultTask(void *argument);

/* Definitions for defaultTask */
osThreadId_t defaultTaskHandle;
const osThreadAttr_t defaultTask_attributes = {
  .name = "defaultTask",
  .priority = (osPriority_t) osPriorityNormal,
  .stack_size = 128 * 4
};


int main(void){


        SCB->CPACR |= (0xF << 20);  // Enable float pointer registers
        __DSB();
        __ISB();

        osKernelInitialize();

        defaultTaskHandle = osThreadNew(StartDefaultTask, NULL, &defaultTask_attributes);

        osKernelStart();

        while (1)
        {
                /* code */
        }
        
}


void StartDefaultTask(void *argument){

        /* Infinite loop */
        while(1){
                Secure_Test_Call();
                printf("Hello from non-secure world\n");
        }
}
