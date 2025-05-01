/******************************************************************************
 * @file     main_s.c
 * @brief    Code template for secure main function
 * @version  V1.1.1
 * @date     10. January 2018
 ******************************************************************************/
/*
 * Copyright (c) 2013-2018 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Use CMSE intrinsics */
#include <arm_cmse.h>
// #include <cmsis_gcc.h>
#include "RTE_Components.h"
#include CMSIS_device_header
#include <stdio.h>
#include "pico/stdlib.h"
#include "secure_config.h"
#include "_rp2350.h"
#include "hardware/structs/systick.h"
#include "hardware/clocks.h"
#include "hardware/structs/sio.h"

/* TZ_START_NS: Start address of non-secure application */
#ifndef TZ_START_NS
#define TZ_START_NS (0x10100200U)
#endif
 
/* typedef for non-secure callback functions */
typedef void (*funcptr_void) (void) __attribute__((cmse_nonsecure_call));

void config_peripherals_be_accessible_by_ns(){
  accessctrl_hw->uart[0] = ACCESSCTRL_PASSWORD_BITS | 0xFF; 
  accessctrl_hw->uart[1] = ACCESSCTRL_PASSWORD_BITS | 0xFF; 
  accessctrl_hw->timer[0] = ACCESSCTRL_PASSWORD_BITS | 0xFF;
  accessctrl_hw->timer[1] = ACCESSCTRL_PASSWORD_BITS | 0xFF; 
  accessctrl_hw->clocks = ACCESSCTRL_PASSWORD_BITS | 0xFF;
  accessctrl_hw->gpio_nsmask[0] = 0x0F ; 
  accessctrl_hw->pads_bank0 = ACCESSCTRL_PASSWORD_BITS | 0xFF; // PADS_BANK0 accessible by everybody
  accessctrl_hw->io_bank[0] = ACCESSCTRL_PASSWORD_BITS | 0xFF; // PADS_BANK0 accessible by everybody
  accessctrl_hw->ticks = ACCESSCTRL_PASSWORD_BITS | 0xFF; // TICKS accessible by everybody
  // accessctrl_hw->usb = ACCESSCTRL_PASSWORD_BITS | 0xFF; // XIP_CTRL accessible by everybody  
} 

#define SYSCLOCK_FREQ 120000 // 120MHz
#define SYSTICK_INTERRUPT_ID 15 // SysTick interrupt ID
void init_systimers(){
  // set clock frequency
  set_sys_clock_khz(SYSCLOCK_FREQ, true); // Set system clock to 120MHz

  // activate the systick
  nvic_hw->iser[0] = (1 << (SYSTICK_INTERRUPT_ID)); // Enable SysTick interrupt in NVIC
  nvic_ns_hw->iser[0] = (1 << (SYSTICK_INTERRUPT_ID)); // Enable SysTick interrupt in NVIC
  nvic_hw->itns[0] |= (1 << (SYSTICK_INTERRUPT_ID)); // Set SysTick interrupt to non-secure
  
  // set interrupt priority
  nvic_hw->iabr[0] = (1 << SYSTICK_INTERRUPT_ID); // Set SysTick interrupt to secure
  nvic_ns_hw->iabr[0] = (1 << SYSTICK_INTERRUPT_ID); // Set SysTick interrupt to non-secure
  
  // set 
  scb_hw->icsr = (1 << 24) ; // set STTNS bit to enable non-secure systick to nonsecure, maybe it is not working

  // enable interrupts
  __enable_irq(); // Enable SysTick interrupt in NVIC
}

/* Secure main() */
int main(void) {

  funcptr_void NonSecure_ResetHandler;
  
  /* Get the core ID */
  uint32_t core_id = sio_hw->cpuid;

  /* Check if the core ID is 0 or 1 */
  if (core_id == 1) {
    while(1) __WFI(); // Sleep core 1
  }

  /* Initialize the system */
  stdio_init_all();

  // Set up the peripheral access control
  config_peripherals_be_accessible_by_ns();
  
  // init_systimers()
  sc_trustzone_init();

  /* Set non-secure main stack (MSP_NS) */
  __TZ_set_MSP_NS(*((uint32_t *)(TZ_START_NS)));
 
  /* Get non-secure reset handler */
  NonSecure_ResetHandler = (funcptr_void)(*( (uint32_t *)((TZ_START_NS) + 4U ) ) ) ;

  // init non secure vtor
  scb_ns_hw->vtor = TZ_START_NS;

  /* Start non-secure state software application */
  NonSecure_ResetHandler();
 
  /* Non-secure software does not return, this code is not executed */
  while (1) {
    __NOP();
  }
}
